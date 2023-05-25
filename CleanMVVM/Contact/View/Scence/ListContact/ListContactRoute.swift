//
//  ListContactRoute.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 25/05/2023.
//

import Foundation
import UIKit

protocol ContactRoute {
    func goToDetail(_ contact: Contact)
}

struct DefaultContactRoute: ContactRoute {
    
    let nav: UINavigationController?
    
    init(nav: UINavigationController?) {
        self.nav = nav
    }
    
    func goToDetail(_ contact: Contact) {
        let vc: DetailContactViewController = .loadFromNib()
        vc.contact = contact
        self.nav?.pushViewController(vc, animated: true)
    }
}
