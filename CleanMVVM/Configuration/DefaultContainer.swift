//
//  DefaultContainer.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation
import Swinject

protocol NameRegisterContainer {
    static var NAME_REGISTER: String { get }
}

extension NameRegisterContainer {
    static var NAME_REGISTER: String { String(describing: self) }
}

struct ContainerConfiguration: Configuration {
    func configure() {
        DefaultContainer.shared.register()
    }
}

struct DefaultContainer {
    
    let container: Container = .init()

    static let shared = DefaultContainer()

    func register() {
        registerDispatcher()
        registerNetwork()
        registerRepository()
    }
    
    fileprivate func registerDispatcher() {
        self.container.register(Dispatcher.self, name: JSONAlamofireDispatcher.NAME_REGISTER) { (_, host) in
            JSONAlamofireDispatcher(host: host)
        }
    }
    
    fileprivate func registerNetwork() {
        self.container.register(ContactNetwork.self) { _ in
            DefaultContactNetwork()
        }
    }
    
    fileprivate func registerRepository() {
        self.container.register(ContactRepository.self) { _ in
            DefaultContactRepository()
        }
    }
}
