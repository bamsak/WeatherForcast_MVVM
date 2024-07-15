//
//  APIEndPoint.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/10/24.
//

import Foundation

protocol APIEndPoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get throws }
    var httpMethod: HTTPMethod { get }
}

extension APIEndPoint {
    func urlRequest() throws -> URLRequest {
        let url = try asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.value
        return urlRequest
    }
}

// MARK: - Private

private extension APIEndPoint {
    func asURL() throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = try queryItems
        guard let url = urlComponents.url
        else {
            throw NetworkError.badURL
        }
        return url
    }
}

