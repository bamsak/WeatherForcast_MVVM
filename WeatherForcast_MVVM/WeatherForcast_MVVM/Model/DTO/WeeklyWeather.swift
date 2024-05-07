//
//  WeeklyWeather.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/7/24.
//

extension DTO {
    struct WeeklyWeather: Decodable {
        let cod: Int
        let message: Int
        let timestampCount: Int
        let list: [List]
        let city: City
        
        private enum CodingKeys: String, CodingKey {
            case cod, message, list, city
            case timestampCount = "cnt"
        }
    }
}

extension DTO.WeeklyWeather {
    struct List: Decodable {
        let dataTime: Int
        let main: CommonWeatherData.Main
        let weather: CommonWeatherData.Weather
        let clouds: CommonWeatherData.Clouds
        let wind: CommonWeatherData.Wind
        let visibility: Int
        let probabilityOfPrecipitation: Double
        let rain: CommonWeatherData.Rain?
        let snow: CommonWeatherData.Snow?
        let system: System
        let dateText: String
        
        private enum CodingKeys: String, CodingKey {
            case main, weather, clouds, wind, visibility, rain, snow
            case dataTime = "dt"
            case probabilityOfPrecipitation = "pop"
            case system = "sys"
            case dateText = "dt_txt"
        }
    }
}

extension DTO.WeeklyWeather.List {
    struct System: Decodable {
        let partOfDay: String
        
        private enum CodingKeys: String, CodingKey {
            case partOfDay = "pod"
        }
    }
}

extension DTO.WeeklyWeather {
    struct City: Decodable {
        let id: Int
        let name: String
        let coordinate: CommonWeatherData.Coordinate
        let country: String
        let population: String
        let timezone: Int
        let sunriseTime: Int
        let sunsetTime: Int
        
        private enum CodingKeys: String, CodingKey {
            case id, name, country, population, timezone
            case coordinate = "coord"
            case sunriseTime = "sunrise"
            case sunsetTime = "sunset"
        }
    }
}

