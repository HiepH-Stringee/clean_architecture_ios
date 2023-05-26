//
//  NetworkResponse.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation

protocol NetworkResponse {
    associatedtype Resource: Any

    func map(data: Data?, url: URL, statusCode: Int) -> Result<Resource, Error>
}

struct IgnoreResponse: NetworkResponse {
    func map(data: Data?, url: URL, statusCode: Int) -> Result<(), Error> {
        return .success(())
    }
}
