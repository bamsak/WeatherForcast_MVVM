//
//  OpenWeatherEndPoint.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/10/24.
//

import Foundation

enum OpenWeatherEndPoint {
    case current(latitude: Double, longitude: Double)
    case weekly(latitude: Double, longitude: Double)
}

extension OpenWeatherEndPoint: APIEndPoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.openai.com"
    }
    
    var path: String {
        return "/data/2.5/\(self.pathType)"
    }
    
    var queries: [URLQueryItem]? {
        get throws {
            switch self {
            case .current(latitude: let latitude, longitude: let longitude),
                    .weekly(latitude: let latitude, longitude: let longitude):
                guard let apiKey = self.apiKey
                else {
                    throw NetworkError.notFoundAPIKey
                }
                return [URLQueryItem(name: "lat", value: "\(latitude)"),
                        URLQueryItem(name: "lon", value: "\(longitude)"),
                        URLQueryItem(name: "appid", value: apiKey)]
            }
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}

// MARK: - private

private extension OpenWeatherEndPoint {
    private var pathType: String {
        switch self {
        case .current:
            return "weather"
        case .weekly:
            return "forecast"
        }
    }
    
    private var apiKey: String? {
        guard let apiKey =  Bundle.main.object(forInfoDictionaryKey: "OpenWeatherAPIKey") as? String
        else {
            return nil
        }
        return apiKey
    }
}
