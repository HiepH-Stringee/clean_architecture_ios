//
//  ContactNetwrok.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 23/05/2023.
//



import Foundation
import RxSwift

protocol ContactNetwork {
    func getListContact(_ searchAfter: [Any]?) -> Observable<([Contact], [Any]?)>
}

struct DefaultContactNetwork: ContactNetwork {
    
    @DispatcherInject(host: .baseUrl, name: JSONAlamofireDispatcher.NAME_REGISTER)
    var dispatcher: Dispatcher
    
    func getListContact(_ searchAfter: [Any]?) -> Observable<([Contact], [Any]?)> {
        dispatcher.fetch(request: ListContactRequest(searchAfter), handler: ListContactResponse())
    }
    
}
