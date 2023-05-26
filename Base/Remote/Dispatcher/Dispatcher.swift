//
//  Dispatcher.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Alamofire
import Foundation
import RxSwift

protocol Dispatcher {
    var host: String { get }

    var progress: Observable<Progress> { get }

    func fetch<Request: NetworkRequest, Response: NetworkResponse>(request: Request, handler: Response) -> Observable<Response.Resource>
}

extension Dispatcher {
    var progress: Observable<Progress> { .empty() }
}
