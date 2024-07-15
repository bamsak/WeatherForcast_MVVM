//
//  HTTPMethod.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/10/24.
//

enum HTTPMethod {
    case get
    
    var value: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}
