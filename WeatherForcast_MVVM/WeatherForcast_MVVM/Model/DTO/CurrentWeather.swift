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

extension DTO.CurrentWeather {
    func asDomain() throws -> Entity.Repository.CurrentWeatherInfo {
        guard let weatherData = weather.last
        else {
            throw MappingError.failedToDomainModel(Entity.Repository.CurrentWeatherInfo.self)
        }
        let weather = Entity.Repository.CommomWeatherInfo.Weather(main: weatherData.main,
                                                                  description: weatherData.description,
                                                                  icon: weatherData.icon)
        let main = Entity.Repository.CommomWeatherInfo.TemperatureInfo(temperature: self.main.temperature,
                                                            feelsLikeTemperature: self.main.feelsLikeTemperature,
                                                            minimumTemperature: self.main.minimumTemperature,
                                                            maximumTemperature: self.main.maximumTemperature)
        return .init(weather: weather, temperatureInfo: main, dataTime: self.dataTime)
    }
}
