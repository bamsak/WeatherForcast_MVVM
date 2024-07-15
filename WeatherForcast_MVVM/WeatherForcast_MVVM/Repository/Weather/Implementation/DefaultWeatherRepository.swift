//
//  DefaultWeatherRepository.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/28/24.
//

final class DefaultWeatherRepository {
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
}

extension DefaultWeatherRepository: CurrentWeatherRepository {
    func fetchCurrentWether(latitude: Double, longitude: Double) async throws -> Entity.Repository.CurrentWeatherInfo {
        let endPoint = OpenWeatherEndPoint.current(latitude: latitude, longitude: longitude)
        let currentWeather: DTO.CurrentWeather = try await apiService.excute(with: endPoint)
        let domainCurrnetWeather = try currentWeather.asDomain()
        return domainCurrnetWeather
    }
}

extension DefaultWeatherRepository: WeeklyWeatherRepository {
    func fetchWeeklyWeather(latitude: Double, longitude: Double) async throws -> Entity.Repository.WeeklyWeatherInfo {
        let endPoint = OpenWeatherEndPoint.weekly(latitude: latitude, longitude: longitude)
        let weeklyWeather: DTO.WeeklyWeather = try await apiService.excute(with: endPoint)
        let domainWeekltyWeather = try weeklyWeather.asDomain()
        return domainWeekltyWeather
    }
}
