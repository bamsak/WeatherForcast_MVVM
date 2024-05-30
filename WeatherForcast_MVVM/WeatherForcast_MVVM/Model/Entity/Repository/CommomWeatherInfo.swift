//
//  CommomWeatherInfo.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/30/24.
//

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
    struct Main {
        let temperature: Double
        let feelsLikeTemperature: Double
        let minimumTemperature: Double
        let maximumTemperature: Double
    }
}
