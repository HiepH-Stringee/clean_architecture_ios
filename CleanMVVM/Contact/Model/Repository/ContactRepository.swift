//
//  ContactRepository.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 25/05/2023.
//

import Foundation
import RxCocoa
import RxSwift

protocol ContactRepository {
    func refresh() -> Observable<[Contact]>
    func nextPage() -> Observable<[Contact]>
    func itemAtIndex(_ index: Int) -> Contact?
}

class DefaultContactRepository: ContactRepository {

    @Inject() var network: ContactNetwork

    var nextSearch: [Any]? = nil
    var contacts: [Contact] = []

    func loadContact(_ search_after: [Any]?) -> Observable<([Contact], [Any]?)> {
        self.network.getListContact(search_after)
    }

    func refresh() -> Observable<[Contact]> {
        self.nextSearch = nil
        return self.nextPage()
    }

    func itemAtIndex(_ index: Int) -> Contact? {
        self.contacts[safe: index]
    }

    func nextPage() -> Observable<[Contact]> {
        self.network.getListContact(self.nextSearch).map { contacts, next in
            if self.nextSearch == nil {
                self.contacts = contacts
            } else {
                self.contacts.append(contentsOf: contacts)
            }
            self.nextSearch = next
            return self.contacts
        }
    }

}
