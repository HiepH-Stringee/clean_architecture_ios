//
//  ListContactInteractor.swift
//  CleanVIPER
//
//  Created by Hiệp Hoàng on 26/05/2023.
//

import Foundation
import RxSwift

class ListContactInteractor: ListContactInteractorInputProtocol {
    
    var network: ContactNetwork
    
    var presenter: ListContactInteractorOutputProtocol?
    
    var items: [Contact] = []
    
    var searchAfter: [Any]? = nil
    
    private let disposeBag = DisposeBag()
    
    init(network: ContactNetwork) {
        self.network = network
    }
    
    func refresh() {
        searchAfter = nil
        loadMore()
    }
    
    func loadMore() {
        network.getListContact(self.searchAfter).subscribe(onNext: { items, next in
            if self.searchAfter == nil {
                self.items = items
            }else {
                self.items.append(contentsOf: items)
            }
            self.searchAfter = next
            self.presenter?.didRetriveContacts(self.items)
            
        }, onError: { error in
            self.presenter?.onError(error)
        }).disposed(by: self.disposeBag)
    }
    
    
}
