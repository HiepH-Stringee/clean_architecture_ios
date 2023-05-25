//
//  Collection+Extention.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 25/05/2023.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
