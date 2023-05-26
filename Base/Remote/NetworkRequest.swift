//
//  NetworkRequest.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation

struct NetworkUtil {
    static let AUTHORIZATION = "X-STRINGEE-AUTH"
    static let JSON_ENCODING: String = "json"
    static let MULTIPART_FORM = "multipart_form"
}

protocol BodyRequest {
    var data: Any { get }
    var encoding: String { get }
}

struct DefaultBodyRequest: BodyRequest {
    var data: Any

    var encoding: String
}

protocol NetworkRequest {
    var path: String { get }

    var method: String { get }

    var parameters: [String: Any]? { get }

    var headers: [String: String]? { get }

    var body: BodyRequest? { get }
}

extension NetworkRequest {

    var parameters: [String: Any]? { nil }

    var headers: [String: String]? {
        return [
            NetworkUtil.AUTHORIZATION: AppSection.access_token
        ]
    }

    var body: BodyRequest? { nil }
}
