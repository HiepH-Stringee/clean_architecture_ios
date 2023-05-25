//
//  Convertable.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation
import RealmSwift

protocol Identifiable {
    associatedtype ID: Hashable

    var id: ID { get set }
}

protocol DomainConvertable: Identifiable {
    associatedtype Domain: ObjectConvertable where Domain.Object == Self, ID == Domain.ID

    var asDomain: Domain { get }
}

protocol ObjectConvertable: Identifiable {
    associatedtype Object: RealmSwift.Object & DomainConvertable where Object.Domain == Self, ID == Object.ID

    func asObject(oldValue: Object?) -> Object
}
