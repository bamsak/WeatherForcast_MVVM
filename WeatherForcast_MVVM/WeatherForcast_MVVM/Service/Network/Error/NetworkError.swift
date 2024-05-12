//
//  NetworkError.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/10/24.
//

enum NetworkError: Error {
    case notFoundAPIKey
    case badURL
    case failedResponseCasting
    case responseError(statusCode: Int)
}
