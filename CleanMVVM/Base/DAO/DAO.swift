//
//  DAO.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation
import RealmSwift

struct DAO<Type: ObjectConvertable> {

    fileprivate var realm: Realm?

    init() {
        do {
            self.realm = try Realm()
        } catch {
            print(error.localizedDescription)
        }
    }

    func findAll(predicate: NSPredicate? = nil, sorts: [NSSortDescriptor] = [], range: ClosedRange<Int>? = nil) -> [Type] {
        self.findAll(predicate: predicate, sorts: sorts, range: range).map { $0.asDomain }
    }

    fileprivate func findAll(predicate: NSPredicate? = nil, sorts: [NSSortDescriptor] = [], range: ClosedRange<Int>? = nil) -> [Type.Object] {
        var results = self.realm?.objects(Type.Object.self)
        if let predicate = predicate {
            results = results?.filter(predicate)
        }
        if !sorts.isEmpty {
            sorts.filter { $0.key != nil }.forEach { sort in
                results = results?.sorted(byKeyPath: sort.key!, ascending: sort.ascending)
            }
        }
        guard let items = results else { return [] }

        if let range = range {
            return range.compactMap { $0 >= 0 ? $0 : nil }
                .compactMap { $0 < items.count ? items[$0] : nil }
        } else {
            return items.map { $0 }
        }
    }

    func find(
        predicate: NSPredicate? = nil,
        sorts: [NSSortDescriptor] = [],
        range: ClosedRange<Int>? = nil
    ) -> Type? { self.findAll(predicate: predicate, sorts: sorts, range: range).first }

    func find(id: Type.ID) -> Type? {
        self.find(id: id)?.asDomain
    }

    fileprivate func find(id: Type.ID) -> Type.Object? { self.realm?.object(ofType: Type.Object.self, forPrimaryKey: id) }

    func save(domain: Type, update: Realm.UpdatePolicy = .error) throws {
        let oldValue: Type.Object? = self.find(id: domain.id)
        try self.realm?.write {
            self.realm?.add(domain.asObject(oldValue: oldValue), update: update)
        }
    }

    func saveAll(domains: [Type], update: Realm.UpdatePolicy = .error) throws {
        let objects = domains.map { domain -> Type.Object in
            let oldValue: Type.Object? = self.find(id: domain.id)
            return domain.asObject(oldValue: oldValue)
        }
        try self.realm?.write {
            self.realm?.add(objects, update: update)
        }
    }

    func deleteAll(predicate: NSPredicate? = nil, sorts: [NSSortDescriptor] = [], range: ClosedRange<Int>? = nil) throws {
        let results: [Type.Object] = self.findAll(predicate: predicate, sorts: sorts, range: range)
        guard !results.isEmpty else { return }
        try self.realm?.write {
            self.realm?.delete(results)
        }
    }

    func delete(id: Type.ID) throws {
        guard let object: Type.Object = self.find(id: id) else { return }
        try self.realm?.write {
            self.realm?.delete(object)
        }
    }

}
