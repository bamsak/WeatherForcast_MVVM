//
//  AppEnvironment.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/8/24.
//

final class AppEnvironment {
    
    // MARK: - Singleton

    static let shared = AppEnvironment()
    
    // MARK: - Service

    private let networkService = NetworkService()
    private let locationService: LocationDataProvidable = LocationService()
    private let apiService: APIService
    
    // MARK: - Repository

    private let weatherRepository: CurrentWeatherRepository & WeeklyWeatherRepository
    private let iconRepository: WeatherIconDataRepository
    private let locationRepository: LocationRepository
    
    // MARK: - UseCase
    
    private let fetchWeatherForCurrentLocationUseCase: FetchWeatherForCurrentLocationUseCase
    
    // MARK: - ViewModel
    
    private let mainViewModel: MainWeatherViewModel
    
    // MARK: - Screen
    
    var mainWeatherViewController: MainWeatherViewController {
        .init(mainWeatherViewModel: mainViewModel)
    }

    // MARK: - Initializer

    private init() {
        self.apiService = APIService(networkService: networkService)
        self.weatherRepository = DefaultWeatherRepository(apiService: apiService)
        self.iconRepository = DefaultImageDataRepostory(networkService: networkService)
        self.locationRepository = DefaultLocationRepository(locationService: locationService)
        self.fetchWeatherForCurrentLocationUseCase = ConcreteFetchWeatherForCurrentLocationUseCase(
            locationRepository: locationRepository,
            weatherIconDataRepository: iconRepository,
            currentWeatherRepository: weatherRepository,
            weeklyWeatherRepository: weatherRepository
        )
        self.mainViewModel = MainWeatherViewModel(fetchWeatherForCurrentUseCase: fetchWeatherForCurrentLocationUseCase)
    }
}
