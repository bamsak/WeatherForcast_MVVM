//
//  WeeklyWeatherInfo.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/30/24.
//

extension Entity.Repository {
    struct WeeklyWeatherInfo {
        let list: [List]
    }
}

extension Entity.Repository.WeeklyWeatherInfo {
    typealias CommonWeatherInfo = Entity.Repository.CommomWeatherInfo
}

extension Entity.Repository.WeeklyWeatherInfo {
    struct List {
        let dataTime: Int
        let dateText: String
        let weather: CommonWeatherInfo.Weather
        let main: CommonWeatherInfo.Main
    }
}
