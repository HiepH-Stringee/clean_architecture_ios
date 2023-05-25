//
//  Bundle+Extension.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation
import UIKit

extension NSObject {
    class var name: String {
        return String(describing: self)
    }
}

extension Bundle {
    func load<T: UIView>(onwer: Any?, options: [UINib.OptionsKey: Any]? = nil) -> T {
        return Bundle.main.loadNibNamed(T.name, owner: onwer, options: options)?.first as! T
    }
}
