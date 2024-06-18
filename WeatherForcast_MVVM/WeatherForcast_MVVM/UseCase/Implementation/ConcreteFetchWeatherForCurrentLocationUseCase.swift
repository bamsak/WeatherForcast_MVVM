//
//  ConcreteFetchWeatherForCurrentLocationUseCase.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/18/24.
//

final class ConcreteFetchWeatherForCurrentLocationUseCase {
    private let locationRepository: LocationRepository
    private let weatherIconDataRepository: WeatherIconDataRepository
    private let currentWeatherRepository: CurrentWeatherRepository
    private let weeklyWeatherRepository: WeeklyWeatherRepository
    
    init(locationRepository: LocationRepository,
         weatherIconDataRepository: WeatherIconDataRepository,
         currentWeatherRepository: CurrentWeatherRepository,
         weeklyWeatherRepository: WeeklyWeatherRepository) {
        self.locationRepository = locationRepository
        self.weatherIconDataRepository = weatherIconDataRepository
        self.currentWeatherRepository = currentWeatherRepository
        self.weeklyWeatherRepository = weeklyWeatherRepository
    }
}

private extension ConcreteFetchWeatherForCurrentLocationUseCase {
    typealias Coordinate = Entity.Repository.LocationInfo.Coordinate
    typealias AllWeatherResult = (currentWeather: Entity.Repository.CurrentWeatherInfo,
                                  weeklyWeather: Entity.Repository.WeeklyWeatherInfo)
    
    func fetchWeatherData(with coordinate: Coordinate) async throws -> AllWeatherResult {
        async let currentWeather = currentWeatherRepository.fetchCurrentWether(latitude: coordinate.latitude,
                                                                               longitude: coordinate.longitude)
        async let weeklyWeather = weeklyWeatherRepository.fetchWeeklyWeather(latitude: coordinate.latitude,
                                                                             longitude: coordinate.longitude)
        return try await (currentWeather, weeklyWeather)
    }
}
