//
//  JSONAlamofireDispatcher.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Alamofire
import Foundation
import RxSwift

struct JSONAlamofireDispatcher: Dispatcher {

    var host: String
    var interceptor: RequestInterceptor? = nil

    func fetch<Request, Response>(request: Request, handler: Response) -> Observable<Response.Resource> where Request: NetworkRequest,
        Response: NetworkResponse
    {
        let method = HTTPMethod(rawValue: request.method.uppercased())
        let url = self.host + request.path
        var parameters: [String: Any]? = request.parameters
        var encoding: ParameterEncoding = URLEncoding.default
        if let body = request.body, let data = body.data as? [String: Any], body.encoding == NetworkUtil.JSON_ENCODING {
            parameters = data
            encoding = JSONEncoding.default
        }
        var headers: HTTPHeaders?
        if let h = request.headers {

            headers = HTTPHeaders(h)
        }
        return Observable
            .just(AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: self.interceptor))
            .flatMap { dataRequest -> Observable<Response.Resource> in
                return .create { observer -> Disposable in
                    dataRequest.responseData { responseData in
                        if let response = responseData.response, let url = response.url {
                            let result = handler.map(data: responseData.data, url: url, statusCode: response.statusCode)
                            switch result {
                            case let .success(resource): observer.onNext(resource)
                            case let .failure(error): observer.onError(error)
                            }
                        } else if let error = responseData.error {
                            observer.onError(NetworkError(domain: "", code: -1, userInfo: ["message": error.localizedDescription]))
                        }
                    }
                    
                    return Disposables.create {
                        dataRequest.cancel()
                    }
                }
            }
    }
}

// MARK: NameRegisterContainer

extension JSONAlamofireDispatcher: NameRegisterContainer {}
