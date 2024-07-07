//
//  CommonWeather.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

import Foundation

extension Presentation.AllWeather {
    enum CommonWeather {
        struct Weather {
            let main: String
            let description: String
            let iconData: Data
        }
    }
}

extension Presentation.AllWeather.CommonWeather {
    struct TemperatureDetail {
        let temperature: String
        let feelsLikeTemperature: String
        let minimumTemperature: String
        let maximumTemperature: String
        
        init(
            temperature: Double,
            feelsLikeTemperature: Double,
            minimumTemperature: Double,
            maximumTemperature: Double
        ) {
            self.temperature = String(format: "%.1f", temperature)
            self.feelsLikeTemperature = String(format: "%.1f", feelsLikeTemperature)
            self.minimumTemperature = String(format: "%.1f", minimumTemperature)
            self.maximumTemperature = String(format: "%.1f", maximumTemperature)
        }
    }
}
