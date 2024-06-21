//
//  CommomWeatherInfo.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/30/24.
//

import Foundation

extension Entity.Repository {
    enum CommomWeatherInfo {
        struct Weather {
            let main: String
            let description: String
            let icon: String
        }
    }
}

extension Entity.Repository.CommomWeatherInfo {
    struct TemperatureInfo {
        let temperature: Double
        let feelsLikeTemperature: Double
        let minimumTemperature: Double
        let maximumTemperature: Double
    }
}

extension Entity.Repository.CommomWeatherInfo.Weather {
    func asUseCaseEntity(with data: Data) -> Entity.UseCase.AllWeatherData.CommomWeatherDetail.Weather {
        return .init(main: self.main, description: self.description, iconData: data)
    }
}

extension Entity.Repository.CommomWeatherInfo.TemperatureInfo {
    func asUseCaseEntity() -> Entity.UseCase.AllWeatherData.CommomWeatherDetail.TemperatureDetail {
        return .init(temperature: self.temperature,
                     feelsLikeTemperature: self.feelsLikeTemperature,
                     minimumTemperature: self.minimumTemperature,
                     maximumTemperature: self.maximumTemperature)
    }
}
