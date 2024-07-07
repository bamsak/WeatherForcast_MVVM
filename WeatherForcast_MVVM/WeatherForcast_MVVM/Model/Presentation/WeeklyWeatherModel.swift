//
//  WeeklyWeatherModel.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

extension Presentation.AllWeather {
    struct WeeklyWeatherModel {
        let list: [List]
    }
}

extension Presentation.AllWeather.WeeklyWeatherModel {
    typealias CommonWeather = Presentation.AllWeather.CommonWeather
}

extension Presentation.AllWeather.WeeklyWeatherModel {
    struct List {
        let dataTime: Int
        let dateText: String
        let weather: CommonWeather.Weather
        let temperature: CommonWeather.TemperatureDetail
    }
}
