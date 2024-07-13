//
//  CurrentWeatherModel.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

extension Presentation.AllWeather {
    struct CurrentWeatherModel {
        let location: String?
        let weather: CommonWeather.Weather
        let temperatureDetail: CommonWeather.TemperatureDetail
        let dataTime: Int
    }
}

// MARK: - Hashable

extension Presentation.AllWeather.CurrentWeatherModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(location)
        hasher.combine(weather)
        hasher.combine(temperatureDetail)
    }
}
