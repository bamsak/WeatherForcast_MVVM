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
    func fetchCurrentWether(latitude: Double, longitude: Double) async throws -> DTO.CurrentWeather {
        let endPoint = OpenWeatherEndPoint.current(latitude: latitude, longitude: longitude)
        let currentWeather: DTO.CurrentWeather = try await apiService.excute(with: endPoint)
        return currentWeather
    }
}

extension DefaultWeatherRepository: WeeklyWeatherRepository {
    func fetchWeeklyWeather(latitude: Double, longitude: Double) async throws -> DTO.WeeklyWeather {
        let endPoint = OpenWeatherEndPoint.weekly(latitude: latitude, longitude: longitude)
        let weeklyWeather: DTO.WeeklyWeather = try await apiService.excute(with: endPoint)
        return weeklyWeather
    }
}
