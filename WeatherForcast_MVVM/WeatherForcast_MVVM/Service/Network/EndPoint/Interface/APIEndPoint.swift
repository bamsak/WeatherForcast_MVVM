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
    var queries: [URLQueryItem]? { get throws }
    var httpMethod: HTTPMethod { get }
}
