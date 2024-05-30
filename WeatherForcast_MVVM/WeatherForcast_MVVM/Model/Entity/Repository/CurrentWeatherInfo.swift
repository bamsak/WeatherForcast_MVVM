//
//  CurrentWeatherInfo.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/30/24.
//


extension Entity.Repository {
    struct CurrentWeatherInfo {
        let weather: Weather
        let main: Main
        let dataTime: Int
    }
}

extension Entity.Repository.CurrentWeatherInfo {
    struct Weather {
        let main: String
        let description: String
        let icon: String
    }
}

extension Entity.Repository.CurrentWeatherInfo {
    struct Main {
        let temperature: Double
        let feelsLikeTemperature: Double
        let minimumTemperature: Double
        let maximumTemperature: Double
    }
}
