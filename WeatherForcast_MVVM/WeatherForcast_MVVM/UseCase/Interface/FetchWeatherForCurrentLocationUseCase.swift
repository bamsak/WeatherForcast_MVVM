//
//  FetchWeatherForCurrentLocationUseCase.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/17/24.
//

protocol FetchWeatherForCurrentLocationUseCase {
    func excute() async throws -> Entity.UseCase.AllWeatherData
}
