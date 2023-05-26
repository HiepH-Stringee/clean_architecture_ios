//
//  ListContactProtocol.swift
//  CleanVIPER
//
//  Created by Hiệp Hoàng on 26/05/2023.
//

import Foundation
import UIKit

protocol ListContactViewProtocol: AnyObject {
    var presenter: ListContactPresenterProtocol? { get set }
    
    func showContacts(_ contacts: [Contact])

    func hideFetching()
    func showLoading()
    func hideLoading()

}

protocol ListContactRouteProtocol: AnyObject {
    static func createListContactModule() -> UIViewController

    func presentContactDetail(from view: ListContactViewProtocol, forContact contact: Contact)
}

protocol ListContactPresenterProtocol: AnyObject {
    var view: ListContactViewProtocol? { get set }
    var interactor: ListContactInteractorInputProtocol? { get set }
    var router: ListContactRouteProtocol? { get set }
    
    func refresh()
    func loadMore()
    func viewDidLoad()
    func showContactDetail(_ contact: Contact)

}

protocol ListContactInteractorOutputProtocol: AnyObject {
    func didRetriveContacts(_ contacts: [Contact])
    func onError(_ error: Error)
}

protocol ListContactInteractorInputProtocol: AnyObject {
    var presenter: ListContactInteractorOutputProtocol? { get set }

    func refresh()
    func loadMore()
}
