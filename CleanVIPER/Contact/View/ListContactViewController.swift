//
//  ViewController.swift
//  CleanVIPER
//
//  Created by Hiệp Hoàng on 26/05/2023.
//

import UIKit
import MBProgressHUD

class ListContactViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    var items: [Contact] = []
    var presenter: ListContactPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.refreshControl = UIRefreshControl()
        tblView.refreshControl?.addTarget(self, action: #selector(needReload), for: .valueChanged)
        tblView.estimatedRowHeight = 50
        tblView.rowHeight = UITableView.automaticDimension
        tblView.dataSource = self
        tblView.delegate = self
        tblView.register(ContactTableViewCell.self, bundle: Bundle(identifier: "com.stringee.CleanMVVM"))
        presenter?.viewDidLoad()
        print(presenter != nil)
    }
    
    @objc func needReload() {
        presenter?.refresh()
    }
}

extension ListContactViewController: ListContactViewProtocol {
    
    func showContacts(_ contacts: [Contact]) {
        items = contacts
        tblView.reloadData()
    }
    
    func hideFetching() {
        tblView.refreshControl?.endRefreshing()
    }
    
    func showLoading() {
        let progressView = MBProgressHUD.showAdded(to: view, animated: true)
        view.isUserInteractionEnabled = false
        progressView.removeFromSuperViewOnHide = true
        progressView.hide(animated: true, afterDelay: 30)
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: self.view, animated: true)
        view.isUserInteractionEnabled = true
    }
    
    
}

extension ListContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactTableViewCell = tblView.dequeueReusableCell(indexPath: indexPath)
        cell.name.text = items[indexPath.row].name
        return cell
    }
}

extension ListContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = items[safe: indexPath.row] {
            presenter?.showContactDetail(item)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 30 {
            presenter?.loadMore()
        }
    }
}
