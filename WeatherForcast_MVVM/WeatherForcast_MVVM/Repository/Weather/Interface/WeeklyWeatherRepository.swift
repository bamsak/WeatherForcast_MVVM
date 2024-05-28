//
//  WeeklyWeatherRepository.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/28/24.
//

protocol WeeklyWeatherRepository {
    func fetchWeeklyWeather(latitude: Double, longitude: Double) async throws -> DTO.WeeklyWeather
}
