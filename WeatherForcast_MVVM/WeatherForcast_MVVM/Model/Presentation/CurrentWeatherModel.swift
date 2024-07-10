//
//  CurrentWeatherModel.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

extension Presentation.AllWeather {
    struct CurrentWeatherModel {
        let location: Location
        let weather: CommonWeather.Weather
        let temperaturDetail: CommonWeather.TemperatureDetail
        let dataTime: Int
    }
}

extension Presentation.AllWeather.CurrentWeatherModel {
    struct Location {
        let city: String?
        let district: String?
    }
}

// MARK: - Hashable

extension Presentation.AllWeather.CurrentWeatherModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(location)
        hasher.combine(weather)
        hasher.combine(temperaturDetail)
    }
}
extension Presentation.AllWeather.CurrentWeatherModel.Location: Hashable { }
