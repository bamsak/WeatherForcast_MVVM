//
//  URLSession+.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/14/24.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
