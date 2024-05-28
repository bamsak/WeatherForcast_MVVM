//
//  CurrentWeatherRepository.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/28/24.
//

protocol CurrentWeatherRepository {
    func fetchCurrentWether(latitude: Double, longitude: Double) async throws -> DTO.CurrentWeather
}
