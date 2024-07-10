//
//  WeeklyWeatherModel.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

extension Presentation.AllWeather {
    struct WeeklyWeatherModel {
        let list: [List]
    }
}

extension Presentation.AllWeather.WeeklyWeatherModel {
    typealias CommonWeather = Presentation.AllWeather.CommonWeather
}

extension Presentation.AllWeather.WeeklyWeatherModel {
    struct List {
        let dateText: String
        let weather: CommonWeather.Weather
        let temperature: CommonWeather.TemperatureDetail
        
        init(
            dataTime: Int,
            weather: CommonWeather.Weather,
            temperature: CommonWeather.TemperatureDetail
        ) {
            self.dateText = dataTime.toFormattedDate()
            self.weather = weather
            self.temperature = temperature
        }
    }
}

// MARK: - Hashable

extension Presentation.AllWeather.WeeklyWeatherModel: Hashable { }
extension Presentation.AllWeather.WeeklyWeatherModel.List: Hashable { }
