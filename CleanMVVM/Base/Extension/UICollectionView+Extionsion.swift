//
//  UICollectionView+Extionsion.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    @objc override class var identifier: String { return Self.name }

    func textSizeHeight(size: CGFloat, text: String, width: CGFloat, height: CGFloat = .greatestFiniteMagnitude, line: Int = 0) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        label.numberOfLines = line
        label.font = UIFont.systemFont(ofSize: size)
        label.text = text
        label.sizeToFit()
        return label.frame.size.height
    }

}

extension UICollectionReusableView {
    @objc class var identifier: String { return Self.name }
}

