//
//  AllWeather.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

/// PresentationModel NameSpace
enum Presentation { }

extension Presentation {
    struct AllWeather { 
        let currentWeather: CurrentWeatherModel
        let weeklyWeather: WeeklyWeatherModel
    }
}

// MARK: - Hashable

extension Presentation.AllWeather: Hashable { }
