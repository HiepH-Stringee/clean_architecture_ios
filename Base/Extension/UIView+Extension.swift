//
//  UIView+Extension.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation
import RxCocoa
import RxSwift

extension UIView {
    enum BorderSide {
        case top
        case bottom
        case left
        case right
    }

    func corners(
        radius: CGFloat,
        maskToBounds: Bool = true,
        maskedCorners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    ) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = maskToBounds
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = maskedCorners
        }
    }

    func corner(radius: CGFloat, maskToBounds: Bool = true, roundingCorners: UIRectCorner = .allCorners) {
        if roundingCorners == .allCorners {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = maskToBounds
        } else {
            let shape = CAShapeLayer()
            shape.bounds = self.frame
            shape.position = self.center
            shape
                .path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius))
                .cgPath
            self.layer.mask = shape
        }
    }

    func circle() {
        self.layoutIfNeeded()
        self.corner(radius: self.frame.width / 2.0, roundingCorners: .allCorners)
    }

    func shadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat, path: CGPath? = nil) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowPath = path
    }

    func border(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }

    func border(side: BorderSide, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        switch side {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        self.layer.addSublayer(border)
    }

    func gradient(colors: [UIColor], start: CGPoint, end: CGPoint, locations: [NSNumber]? = nil) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = start
        gradient.endPoint = end
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }

    func anchor(
        top: NSLayoutYAxisAnchor?,
        left: NSLayoutXAxisAnchor?,
        bottom: NSLayoutYAxisAnchor?,
        right: NSLayoutXAxisAnchor?,
        paddingTop: CGFloat,
        paddingLeft: CGFloat,
        paddingBottom: CGFloat,
        paddingRight: CGFloat,
        width: CGFloat?,
        height: CGFloat?
    ) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    

    func showWithAnimation(animatedView: UIView, in view: UIView?) {

        self.frame = view!.bounds
        view?.addSubview(self)
        view?.bringSubviewToFront(self)
        animatedView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        animatedView.alpha = 0
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: CGFloat(0.8),
            initialSpringVelocity: CGFloat(10.0),
            options: [],
            animations: {
                animatedView.alpha = 1.0
                animatedView.transform = CGAffineTransform.identity
            },
            completion: nil
        )

    }

    func hideWithAnimation(animatedView: UIView, callback: (() -> Void)?) {
        animatedView.alpha = 1.0
        animatedView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            animatedView.alpha = 0.0
            animatedView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            self.removeFromSuperview()
            callback?()
        })
    }
}
