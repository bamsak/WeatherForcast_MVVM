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
        let currentTemperature: String
        let minMaxTemperature: String?
        
        init(
            currentTemperature: Double,
            minimumTemperature: Double,
            maximumTemperature: Double
        ) {
            self.currentTemperature = String(format: "%.1f", currentTemperature) + "°"
            let minimumTemperature = String(format: "%.1f", minimumTemperature)
            let maximumTemperature = String(format: "%.1f", maximumTemperature)
            self.minMaxTemperature = "최저 \(minimumTemperature)° 최고 \(maximumTemperature)°"
        }
        
        init(
            currentTemperature: Double,
            minMaxTemperature: String? = nil
        ) {
            self.currentTemperature = String(format: "%.1f", currentTemperature) + "°"
            self.minMaxTemperature = minMaxTemperature
        }
    }
}

// MARK: - Hashable

extension Presentation.AllWeather.CommonWeather.Weather: Hashable { }
extension Presentation.AllWeather.CommonWeather.TemperatureDetail: Hashable { }
