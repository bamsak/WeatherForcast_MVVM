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
    case icon(name: String)
}

extension OpenWeatherEndPoint: APIEndPoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        switch self {
        case .icon:
            return "openweathermap.org"
        default:
            return "api.openweathermap.org"
        }
    }
    
    var path: String {
        switch self {
        case .current, .weekly:
            return "/data/2.5/\(pathType)"
        case .icon:
            return "/img/wn/\(pathType)@2x.png"
        }
    }
    
    var queryItems: [URLQueryItem]? {
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
                        URLQueryItem(name: "appid", value: apiKey),
                        URLQueryItem(name: "units", value: "metric")]
            case .icon:
                return nil
            }
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}

// MARK: - private

private extension OpenWeatherEndPoint {
    var pathType: String {
        switch self {
        case .current:
            return "weather"
        case .weekly:
            return "forecast"
        case .icon(let name):
            return "\(name)"
       }
    }
    
    var apiKey: String? {
        guard let apiKey =  Bundle.main.object(forInfoDictionaryKey: "OpenWeatherAPIKey") as? String
        else {
            return nil
        }
        return apiKey
    }
}
