//
//  ContactNetwork.swift
//  CleanVIPER
//
//  Created by Hiệp Hoàng on 26/05/2023.
//

import Foundation
import RxSwift

let baseUrl = "https://stringee-dev.stringeex.com/v1/"

protocol ContactNetwork {
    func getListContact(_ searchAfter: [Any]?) -> Observable<([Contact], [Any]?)>
}

struct DefaultContactNetwork: ContactNetwork {
    
    @DispatcherInject(host: baseUrl, name: JSONAlamofireDispatcher.NAME_REGISTER)
    var dispatcher: Dispatcher
    
    func getListContact(_ searchAfter: [Any]?) -> Observable<([Contact], [Any]?)> {
        dispatcher.fetch(request: ListContactRequest(searchAfter), handler: ListContactResponse())
    }
    
}
