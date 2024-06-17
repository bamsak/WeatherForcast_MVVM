//
//  CurrentWeatherDetail.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/17/24.
//

extension Entity.UseCase.AllWeatherData {
    struct CurrentWeatherDetail {
        let weather: CommomWeatherDetail.Weather
        let temperatureDetail: CommomWeatherDetail.TemperatureDetail
        let dataTime: Int
    }
}
