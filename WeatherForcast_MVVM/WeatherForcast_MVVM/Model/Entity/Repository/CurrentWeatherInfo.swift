//
//  CurrentWeatherInfo.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/30/24.
//

extension Entity.Repository {
    struct CurrentWeatherInfo {
        let weather: CommomWeatherInfo.Weather
        let main: CommomWeatherInfo.Main
        let dataTime: Int
    }
}
