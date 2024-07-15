//
//  CurrentWeatherInfo.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/30/24.
//

import Foundation

extension Entity.Repository {
    struct CurrentWeatherInfo {
        let weather: CommomWeatherInfo.Weather
        let temperatureInfo: CommomWeatherInfo.TemperatureInfo
        let dataTime: Int
    }
}

extension Entity.Repository.CurrentWeatherInfo {
    func asUseCaseEntity(with data: Data) -> Entity.UseCase.AllWeatherData.CurrentWeatherDetail {
        return .init(weather: self.weather.asUseCaseEntity(with: data),
                    temperatureDetail: self.temperatureInfo.asUseCaseEntity(),
                    dataTime: self.dataTime)
    }
}
