//
//  AllWeatherData.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/17/24.
//

extension Entity.UseCase {
    struct AllWeatherData {
        let location: LocationDetail
        let currentWeather: CurrentWeatherDetail
        let weeklyWeather: WeeklyWeatherDetail
    }
}
