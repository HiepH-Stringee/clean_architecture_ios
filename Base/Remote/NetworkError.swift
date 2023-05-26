//
//  NetworkError.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 19/05/2023.
//

import Foundation

struct NetworkError: Error {
    var domain: String

    var code: Int

    var userInfo: [String: String]? = nil

    var status: StatusCode? {
        switch self.code {
        case 100:
            return .continue
        case 101:
            return .switchingProtocols
        case 102:
            return .processing
        case 200:
            return .ok
        case 201:
            return .created
        case 202:
            return .accepted
        case 203:
            return .nonAuthoritativeInformation
        case 204:
            return .noContent
        case 205:
            return .resetContent
        case 206:
            return .partialContent
        case 207:
            return .multiStatus
        case 208:
            return .alreadyReported
        case 226:
            return .imUsed
        case 300:
            return .multipleChoices
        case 301:
            return .movedPermanently
        case 302:
            return .found
        case 303:
            return .seeOther
        case 304:
            return .notModified
        case 305:
            return .useProxy
        case 306:
            return .switchProxy
        case 307:
            return .temporaryRedirect
        case 308:
            return .permanentRedirect
        case 400:
            return .badRequest
        case 401:
            return .unAuthorized
        case 402:
            return .paymentRequired
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 405:
            return .methodNotAllowed
        case 406:
            return .notAcceptable
        case 407:
            return .proxyAuthenticationRequired
        case 408:
            return .requestTimeout
        case 409:
            return .conflict
        case 410:
            return .gone
        case 411:
            return .lengthRequired
        case 412:
            return .preconditionFailed
        case 413:
            return .payloadTooLarge
        case 414:
            return .uriTooLong
        case 415:
            return .unsupportedMediaType
        case 416:
            return .rangeNotSatisfiable
        case 417:
            return .expectationFailed
        case 418:
            return .imATeapot
        case 421:
            return .misdirectedRequest
        case 422:
            return .unprocessableEntity
        case 423:
            return .locked
        case 424:
            return .failedDependency
        case 426:
            return .upgradeRequired
        case 428:
            return .preconditionRequired
        case 429:
            return .tooManyRequests
        case 431:
            return .requestHeaderFieldsTooLarge
        case 451:
            return .unavailableForLegalReasons
        case 500:
            return .internalServerError
        case 501:
            return .notImplemented
        case 502:
            return .badGateway
        case 503:
            return .serviceUnavailable
        case 504:
            return .gatewayTimeout
        case 505:
            return .httpVersionNotSupported
        case 506:
            return .variantAlsoNegotiates
        case 507:
            return .insufficientStorage
        case 508:
            return .loopDetected
        case 510:
            return .notExtended
        case 511:
            return .networkAuthenticationRequired
        default:
            return nil
        }
    }

    var localizedDescription: String {
        return "Error request url '\(self.domain)' with status \(self.code): \((self.userInfo?["message"]) ?? "")"
    }
}

enum StatusCode: Int {
    typealias RawValue = Int

    case `continue` = 100
    case switchingProtocols = 101
    case processing = 102
    case ok = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case multiStatus = 207
    case alreadyReported = 208
    case imUsed = 226
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case switchProxy = 306
    case temporaryRedirect = 307
    case permanentRedirect = 308
    case badRequest = 400
    case unAuthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case payloadTooLarge = 413
    case uriTooLong = 414
    case unsupportedMediaType = 415
    case rangeNotSatisfiable = 416
    case expectationFailed = 417
    case imATeapot = 418
    case misdirectedRequest = 421
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case unavailableForLegalReasons = 451
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insufficientStorage = 507
    case loopDetected = 508
    case notExtended = 510
    case networkAuthenticationRequired = 511
}
