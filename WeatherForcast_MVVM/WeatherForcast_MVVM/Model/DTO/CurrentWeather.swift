//
//  CurrentWeather.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/6/24.
//

extension DTO {
    struct CurrentWeather: Decodable {
        let coordinate: Coordinate
        let weather: [Weather]
        let base: String
        let main: Main
        let visibility: Int
        let wind: Wind
        let rain: Rain?
        let snow: Snow?
        let dataTime: Int
        let system: System
        let timezone: Int
        let id: Int
        let name: String
        let cod: Int
        
        private enum CodingKeys: String, CodingKey {
            case weather, base, main, visibility, wind, rain, snow, dataTime, timezone, id, name, cod
            case coordinate = "coord"
            case system = "sys"
        }
    }
}

extension DTO {
    struct Coordinate: Decodable {
        let longitude: Double
        let latitude: Double
        
        private enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
    }
}

extension DTO {
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
}

extension DTO {
    struct Main: Decodable {
        let temperature: Double
        let feelsLikeTemperature: Double
        let minimumTemperature: Double
        let maximumTemperature: Double
        let pressure: Int
        let humidity: Int
        let seaLevel: Int
        let groundLevel: Int
        
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

extension DTO {
    struct Wind: Decodable {
        let speed: Double
        let direction: Int
        let gust: Double
        
        private enum CodingKeys: String, CodingKey {
            case speed, gust
            case direction = "deg"
        }
    }
}

extension DTO {
    struct Rain: Decodable {
        let oneHour: Double?
        let threeHour: Double?
        
        private enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
            case threeHour = "3h"
        }
    }
}

extension DTO {
    struct Snow: Decodable {
        let oneHour: Double?
        let threeHour: Double?
        
        private enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
            case threeHour = "3h"
        }
    }
}

extension DTO {
    struct System: Decodable {
        let type: Int
        let id: Int
        let country: String
        let sunriseTime: Int
        let sunsetTime: Int
        
        private enum CodingKeys: String, CodingKey {
            case type, id, country
            case sunriseTime = "sunrise"
            case sunsetTime = "sunset"
        }
    }
}
