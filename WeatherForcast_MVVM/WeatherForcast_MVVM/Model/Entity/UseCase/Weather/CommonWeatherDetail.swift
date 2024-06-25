//
//  CommonWeatherDetail.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/17/24.
//

import Foundation

extension Entity.UseCase.AllWeatherData {
    enum CommomWeatherDetail {
        struct Weather {
            let main: String
            let description: String
            let iconData: Data
        }
    }
}

extension Entity.UseCase.AllWeatherData.CommomWeatherDetail {
    struct TemperatureDetail {
        let temperature: Double
        let feelsLikeTemperature: Double
        let minimumTemperature: Double
        let maximumTemperature: Double
    }
}
