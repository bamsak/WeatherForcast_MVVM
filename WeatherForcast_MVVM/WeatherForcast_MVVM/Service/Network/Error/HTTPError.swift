//
//  HTTPError.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/21/24.
//

extension NetworkError {
    enum HTTPError: Error {
        case badRequest(code: Int)
        case unauthorized(code: Int)
        case forbidden(code: Int)
        case notFound(code: Int)
        case methodNotAllowed(code: Int)
        case notAcceptable(code: Int)
        case requestTimeout(code: Int)
        case other4XXError(code: Int)
        
        case internalServerError(code: Int)
        case badGateway(code: Int)
        case serviceUnavailabel(code: Int)
        case gatewayTimeout(code: Int)
        case other5XXError(code: Int)
        
        init?(statusCode: Int) {
            switch statusCode {
            case 400:
                self = .badRequest(code: statusCode)
            case 401:
                self = .unauthorized(code: statusCode)
            case 403:
                self = .forbidden(code: statusCode)
            case 404:
                self = .notFound(code: statusCode)
            case 405:
                self = .methodNotAllowed(code: statusCode)
            case 406:
                self = .notAcceptable(code: statusCode)
            case 408:
                self = .requestTimeout(code: statusCode)
            case 402, 407, 409..<500:
                self = .other4XXError(code: statusCode)
            case 500:
                self = .internalServerError(code: statusCode)
            case 502:
                self = .badGateway(code: statusCode)
            case 503:
                self = .serviceUnavailabel(code: statusCode)
            case 504:
                self = .gatewayTimeout(code: statusCode)
            case 501, 505..<600:
                self = .other5XXError(code: statusCode)
            default:
                return nil
            }
        }
    }
}

extension NetworkError.HTTPError: CustomStringConvertible {
    var description: String {
        switch self {
        case .badRequest(let code):
            "HTTP Error \(code): BadRequest"
        case .unauthorized(let code):
            "HTTP Error \(code): Unauthorized"
        case .forbidden(let code):
            "HTTP Error \(code): Forbidden"
        case .notFound(let code):
            "HTTP Error \(code): Not Found"
        case .methodNotAllowed(let code):
            "HTTP Error \(code): Method Not Allowed"
        case .notAcceptable(let code):
            "HTTP Error \(code): Not Acceptable"
        case .requestTimeout(let code):
            "HTTP Error \(code): Request Timeout"
        case .other4XXError(let code):
            "HTTP Error \(code): 4XX Other Error"
        case .internalServerError(let code):
            "HTTP Error \(code): Internal Server Error"
        case .badGateway(let code):
            "HTTP Error \(code): Bad Gateway"
        case .serviceUnavailabel(let code):
            "HTTP Error \(code): Service Unavailabel"
        case .gatewayTimeout(let code):
            "HTTP Error \(code): Gateway Timeout"
        case .other5XXError(let code):
            "HTTP Error \(code): 5XX Other Error"
        }
    }
}
