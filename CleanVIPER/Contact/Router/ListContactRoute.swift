//
//  ListContactRoute.swift
//  CleanVIPER
//
//  Created by Hiệp Hoàng on 26/05/2023.
//

import Foundation
import UIKit

class ListContactRoute: ListContactRouteProtocol {
    static func createListContactModule() -> UIViewController {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let view = nav.viewControllers.first as! ListContactViewController
        
        let presenter = ListContactPresenter()
        let interactor = ListContactInteractor(network: DefaultContactNetwork())
        let router = ListContactRoute()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return nav
    }
    
    func presentContactDetail(from view: ListContactViewProtocol, forContact contact: Contact) {
        let vc: DetailContactViewController = .init(nibName: DetailContactViewController.identifier, bundle: .init(identifier: "com.stringee.CleanMVVM"))
        vc.contact = contact
        
        if let view = view as? UIViewController {
            view.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
