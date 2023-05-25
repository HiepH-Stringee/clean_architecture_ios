//
//  Configuration.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation

protocol Configuration {
    func configure()
}

struct DefaultConfiguration: Configuration {
    
    fileprivate var configurations: [Configuration]
    
    init() {
        self.configurations = []
    }
    
    init(_ value: Configuration...) {
        self.configurations = value
    }
    
    func configure() {
        self.configurations.forEach { $0.configure() }
    }
    
    mutating func remove() {
        self.configurations.removeAll()
    }
    
    mutating func add(_ configuration: Configuration) {
        self.configurations.append(configuration)
    }
}
