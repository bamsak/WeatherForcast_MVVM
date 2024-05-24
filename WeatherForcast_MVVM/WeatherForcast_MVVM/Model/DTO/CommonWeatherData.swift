//
//  CommonWeatherData.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/6/24.
//

typealias CommonWeatherData = DTO.CommonWeatherData
/// DTO NameSpace
enum DTO { 
    /// Model for both current and weekly weather
    enum CommonWeatherData { }
}

extension DTO.CommonWeatherData {
    struct Coordinate: Decodable {
        let longitude: Double
        let latitude: Double
        
        private enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
    }
}

extension DTO.CommonWeatherData {
    struct Main: Decodable {
        let temperature: Double
        let feelsLikeTemperature: Double
        let minimumTemperature: Double
        let maximumTemperature: Double
        let pressure: Int
        let humidity: Int
        let seaLevel: Int?
        let groundLevel: Int?
        
        private enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case feelsLikeTemperature = "feels_like"
            case minimumTemperature = "temp_min"
            case maximumTemperature = "temp_max"
            case pressure, humidity
            case seaLevel = "sea_level"
            case groundLevel = "grnd_level"
        }
    }
}

extension DTO.CommonWeatherData {
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
}

extension DTO.CommonWeatherData {
    struct Clouds: Decodable {
        let all: Int
    }
}

extension DTO.CommonWeatherData {
    struct Wind: Decodable {
        let speed: Double
        let direction: Int
        let gust: Double?
        
        private enum CodingKeys: String, CodingKey {
            case speed, gust
            case direction = "deg"
        }
    }
}

extension DTO.CommonWeatherData {
    struct Rain: Decodable {
        let oneHour: Double?
        let threeHour: Double?
        
        private enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
            case threeHour = "3h"
        }
    }
}

extension DTO.CommonWeatherData {
    struct Snow: Decodable {
        let oneHour: Double?
        let threeHour: Double?
        
        private enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
            case threeHour = "3h"
        }
    }
}

