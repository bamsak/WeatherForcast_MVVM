//
//  WeeklyWeatherInfo.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/30/24.
//

import Foundation

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
        let temperatureInfo: CommonWeatherInfo.TemperatureInfo
    }
}

// MARK: - Mapping Method

extension Entity.Repository.WeeklyWeatherInfo.List {
    func asUseCaseEntity(with data: Data) -> Entity.UseCase.AllWeatherData.WeeklyWeatherDetail.List {
        return .init(dataTime: self.dataTime,
                     dateText: self.dateText,
                     weather: self.weather.asUseCaseEntity(with: data),
                     temperatureDetail: self.temperatureInfo.asUseCaseEntity())
    }
}
