//
//  Section.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 23/05/2023.
//

import Foundation

@propertyWrapper
struct Section {

    private var key: String

    init(key: String) {
        self.key = key
        self.wrappedValue = UserDefaults.standard.value(forKey: key) as? String ?? ""
    }

    var wrappedValue: String {
        get {
            UserDefaults.standard.value(forKey: self.key) as? String ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: self.key)
        }
    }
}
