//
//  UIViewController+Extension.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation
import UIKit

extension UIViewController {

    class var identifier: String { return Self.name }

    class var segueIdentifier: String { return "show\(Self.name)" }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

    func ShowAlertLog(title: String, messager: String) {
        let dialogMessage = UIAlertController(title: title, message: messager, preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        dialogMessage.addAction(okAlert)
        DispatchQueue.main.async {
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }

    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
}
