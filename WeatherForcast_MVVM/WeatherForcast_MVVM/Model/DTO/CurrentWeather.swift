//
//  CurrentWeather.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/6/24.
//

extension DTO {
    struct CurrentWeather: Decodable {
        let coordinate: CommonWeatherData.Coordinate
        let weather: [CommonWeatherData.Weather]
        let base: String
        let main: CommonWeatherData.Main
        let visibility: Int
        let wind: CommonWeatherData.Wind
        let rain: CommonWeatherData.Rain?
        let snow: CommonWeatherData.Snow?
        let dataTime: Int
        let system: System
        let timezone: Int
        let id: Int
        let name: String
        let cod: Int
        
        private enum CodingKeys: String, CodingKey {
            case weather, base, main, visibility, wind, rain, snow, timezone, id, name, cod
            case dataTime = "dt"
            case coordinate = "coord"
            case system = "sys"
        }
    }
}

extension DTO.CurrentWeather {
    struct System: Decodable {
        let type: Int?
        let id: Int?
        let country: String?
        let sunriseTime: Int
        let sunsetTime: Int
        
        private enum CodingKeys: String, CodingKey {
            case type, id, country
            case sunriseTime = "sunrise"
            case sunsetTime = "sunset"
        }
    }
}
