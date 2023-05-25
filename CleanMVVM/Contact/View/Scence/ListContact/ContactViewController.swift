//
//  ViewController.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import RxCocoa
import RxGesture
import RxSwift
import UIKit

class ContactViewController: UIViewController {

    @IBOutlet var tblView: UITableView!

    var viewModel: ContactViewModel!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "list contact"
        self.viewModel = .init(
            repo: DefaultContactRepository(),
            route: DefaultContactRoute(nav: self.navigationController)
        )
        self.configureTableView()
        self.bindViewModel()
    }

    private func configureTableView() {
        self.tblView.refreshControl = UIRefreshControl()
        self.tblView.estimatedRowHeight = 50
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.register(ContactTableViewCell.self)
    }

    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:))).mapToVoid().asDriverOnErrorJustComplete()
        let pull = self.tblView.refreshControl!.rx.controlEvent(.valueChanged).asDriver()

        let input = ContactViewModel.Input(
            refresh: Driver.merge(viewWillAppear, pull),
            selection: self.tblView.rx.itemSelected.asDriver(),
            loadMore: self.tblView.rx.didNeedLoadMore.asDriver()
        )
        
        let output = self.viewModel.transform(input: input)

        output.contacts
            .drive(self.tblView.rx.items(cellIdentifier: ContactTableViewCell.identifier, cellType: ContactTableViewCell.self)) { _, contact, cell in
                cell.name.text = contact.name
            }.disposed(by: self.disposeBag)

        output.fetching
            .drive(self.tblView.refreshControl!.rx.isRefreshing)
            .disposed(by: self.disposeBag)
        
        output.loading.drive(self.view.rx.isLoading).disposed(by: self.disposeBag)
        
        output.toDetail.drive().disposed(by: self.disposeBag)
        
    }

}
