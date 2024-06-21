//
//  WeeklyWeatherDetail.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/17/24.
//

extension Entity.UseCase.AllWeatherData {
    struct WeeklyWeatherDetail {
        let list: [List]
    }
}

extension Entity.UseCase.AllWeatherData.WeeklyWeatherDetail {
    typealias CommonWeatherDetail = Entity.UseCase.AllWeatherData.CommomWeatherDetail
}

extension Entity.UseCase.AllWeatherData.WeeklyWeatherDetail {
    struct List {
        let dataTime: Int
        let dateText: String
        let weather: CommonWeatherDetail.Weather
        let temperatureDetail: CommonWeatherDetail.TemperatureDetail
    }
}
