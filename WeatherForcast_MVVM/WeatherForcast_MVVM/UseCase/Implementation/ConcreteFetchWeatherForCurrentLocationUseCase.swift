//
//  ConcreteFetchWeatherForCurrentLocationUseCase.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/18/24.
//

import Foundation

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

extension ConcreteFetchWeatherForCurrentLocationUseCase: FetchWeatherForCurrentLocationUseCase {
    func excute() async throws -> Entity.UseCase.AllWeatherData {
        let location = try await locationRepository.fetchLocation()
        let weatherData = try await fetchWeatherData(with: location.coordinate)
        async let weeklyWeatheerDetail = convertToWeeklyWeatherDetail(weatherData.weeklyWeather.list)
        async let currentWeatherDetail = convertToCurrentWEatherDetail(weatherData.currentWeather)
        return try await .init(location: location.asUseCaseEntity(),
                     currentWeather: currentWeatherDetail,
                     weeklyWeather: weeklyWeatheerDetail)
    }
}

// MARK: - TypeAliase

private extension ConcreteFetchWeatherForCurrentLocationUseCase {
    /// - Repository Entity Coordinate
    typealias Coordinate = Entity.Repository.LocationInfo.Coordinate
    /// - Repository Entity CurrentWeather with WeeklyWeather
    typealias AllWeatherResult = (currentWeather: Entity.Repository.CurrentWeatherInfo,
                                  weeklyWeather: Entity.Repository.WeeklyWeatherInfo)
    
    typealias RepositoryListEntity = Entity.Repository.WeeklyWeatherInfo.List
    typealias UseCaseListEntity = Entity.UseCase.AllWeatherData.WeeklyWeatherDetail.List
    
}

// MARK: - Private Method

private extension ConcreteFetchWeatherForCurrentLocationUseCase {
    func fetchWeatherData(with coordinate: Coordinate) async throws -> AllWeatherResult {
        async let currentWeather = currentWeatherRepository.fetchCurrentWether(latitude: coordinate.latitude,
                                                                               longitude: coordinate.longitude)
        async let weeklyWeather = weeklyWeatherRepository.fetchWeeklyWeather(latitude: coordinate.latitude,
                                                                             longitude: coordinate.longitude)
        return try await (currentWeather, weeklyWeather)
    }
    
    func convertToWeeklyWeatherDetail(_ repositoryListEntities: [RepositoryListEntity]) async throws ->
    Entity.UseCase.AllWeatherData.WeeklyWeatherDetail {
        var useCaseListEntities = [UseCaseListEntity](repeating: UseCaseListEntity(), count: repositoryListEntities.count)
    
        try await withThrowingTaskGroup(of: (Int, UseCaseListEntity).self) { [weak self] group in
            guard let self = self else { throw BindingError.failedSelfBinding }
            repositoryListEntities.enumerated().forEach { index, item in
                group.addTask {
                    let iconData = try await self.weatherIconDataRepository.fetchIconData(item.weather.icon)
                    return (index, item.asUseCaseEntity(with: iconData))
                }
            }
    
            for try await (index, list) in group {
                useCaseListEntities[index] = list
            }
        }
    
        return .init(list: useCaseListEntities)
    }
    
    func convertToCurrentWEatherDetail(_ repositoryCurrentWeatherEntity: Entity.Repository.CurrentWeatherInfo) async throws -> Entity.UseCase.AllWeatherData.CurrentWeatherDetail {
        let iconData = try await weatherIconDataRepository.fetchIconData(repositoryCurrentWeatherEntity.weather.icon)
        return .init(weather: repositoryCurrentWeatherEntity.weather.asUseCaseEntity(with: iconData),
                     temperatureDetail: repositoryCurrentWeatherEntity.temperatureInfo.asUseCaseEntity(),
                     dataTime: repositoryCurrentWeatherEntity.dataTime)
    }
}

// MARK: - Private Extensition UseCaseEntity Initializer

private extension Entity.UseCase.AllWeatherData.WeeklyWeatherDetail.List {
    /// empty initializer
    init() {
        self.dataTime = 0
        self.dateText = ""
        self.temperatureDetail = Entity.UseCase.AllWeatherData.CommomWeatherDetail.TemperatureDetail(temperature: 0,
                                                                                                     feelsLikeTemperature: 0,
                                                                                                     minimumTemperature: 0,
                                                                                                     maximumTemperature: 0)
        self.weather = Entity.UseCase.AllWeatherData.CommomWeatherDetail.Weather(main: "",
                                                                                 description: "",
                                                                                 iconData: Data())
    }
}
