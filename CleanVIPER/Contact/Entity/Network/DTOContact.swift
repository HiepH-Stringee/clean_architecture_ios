//
//  ContactRequest.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 23/05/2023.
//

import Alamofire
import Foundation
import SwiftyJSON

struct ListContactRequest: NetworkRequest {

    var searchAfter: [Any]?

    var path: String = "contact"

    var method: String = HTTPMethod.get.rawValue

    var parameters: [String: Any]? {
        var params = [
            "version": 2,
            "contact_type": 0,
            "sort_order": "desc",
            "sort_by": "created",
            "limit": 20,
            "order_direction": "next",
            "dir": "ltr"
        ] as [String: Any]

        if self.searchAfter != nil {
            params["search_after"] = self.searchAfter
        }

        return params

    }

    init(_ searchAfter: [Any]?) {
        self.searchAfter = searchAfter
    }
}

struct ListContactResponse: NetworkResponse {
    func map(data: Data?, url : URL, statusCode : Int) -> Result<([Contact], [Any]?), Error> {
        if StatusCode(rawValue: statusCode) == .ok {
            if let data = data, let json = try? JSON(data: data) {
                let contacts = json["data"]["rows"].arrayValue.map { item in
                    Contact(id: item["id"].stringValue,
                            name: item["name"].stringValue,
                            phone: item["phone"].stringValue)
                }
                let searchAfter = json["data"]["search_after"].arrayObject
                return .success((contacts, searchAfter))
            }else {
                return .failure(NetworkError(domain: url.absoluteString, code: statusCode))
            }
        }else {
            return .failure(NetworkError(domain: url.absoluteString, code: statusCode))
        }

    }
}
