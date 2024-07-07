//
//  CurrentWeatherModel.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

extension Presentation.AllWeather {
    struct CurrentWeatherModel {
        let weather: CommonWeather.Weather
        let temperaturDetail: CommonWeather.TemperatureDetail
        let dataTime: Int
    }
}
