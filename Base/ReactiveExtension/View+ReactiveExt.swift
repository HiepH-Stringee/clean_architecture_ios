//
//  View+ReactiveExt.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 25/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
import MBProgressHUD

extension Reactive where Base: UIView {
    public var isLoading: Binder<Bool> {
        return Binder(self.base) { view, isLoading in
            if isLoading {
                let progressView = MBProgressHUD.showAdded(to: view, animated: true)
                view.isUserInteractionEnabled = false
                progressView.removeFromSuperViewOnHide = true
                progressView.hide(animated: true, afterDelay: 30)
            }else {
                MBProgressHUD.hide(for: view, animated: true)
                view.isUserInteractionEnabled = true
            }

        }
    }
}

extension Reactive where Base: UIScrollView {
    
    public var didNeedLoadMore: ControlEvent<Void> {
        let source = delegate.methodInvoked(#selector(UIScrollViewDelegate.scrollViewDidEndDragging(_:willDecelerate:)))
            .map { _ in }
            .filter { _ in
                let currentOffset = self.base.contentOffset.y
                let maximumOffset = self.base.contentSize.height - self.base.frame.size.height
                return maximumOffset - currentOffset <= 30
            }
        return ControlEvent(events: source)
    }
}

