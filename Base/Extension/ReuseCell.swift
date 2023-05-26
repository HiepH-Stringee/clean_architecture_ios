//
//  ReuseCell.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(kind: String, indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }

    func register<T: UICollectionViewCell>(_: T.Type, bundle: Bundle? = nil) {
        self.register(UINib(nibName: T.name, bundle: bundle), forCellWithReuseIdentifier: T.identifier)
    }

    func register<T: UICollectionReusableView>(_: T.Type, bundle: Bundle? = nil, supplementaryViewOfKind kind: String) {
        self.register(UINib(nibName: T.name, bundle: bundle), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    func register<T: UITableViewCell>(_: T.Type, bundle: Bundle? = nil) {
        self.register(UINib(nibName: T.name, bundle: bundle), forCellReuseIdentifier: T.identifier)
    }
}
