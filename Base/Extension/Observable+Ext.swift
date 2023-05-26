//
//  Observable+Ext.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation
import RxCocoa
import RxSwift

public extension ObservableType where Element == Bool {
    /// Boolean not operator
    func not() -> Observable<Bool> {
        return self.map(!)
    }

}

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

extension ObservableType {

    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
