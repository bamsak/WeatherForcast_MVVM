//
//  MainWeatherViewModel.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

final class MainWeatherViewModel {
    private let fetchWeatherForCurrentUseCase: FetchWeatherForCurrentLocationUseCase
    
    init(fetchWeatherForCurrentUseCase: FetchWeatherForCurrentLocationUseCase) {
        self.fetchWeatherForCurrentUseCase = fetchWeatherForCurrentUseCase
    }
}


// MARK: - typeAliase

private extension MainWeatherViewModel {
    
    // MARK: - Entity
    
    typealias EntityCurrentWeather = Entity.UseCase.AllWeatherData.CurrentWeatherDetail
    typealias EntityLocation = Entity.UseCase.AllWeatherData.LocationDetail
    typealias EntityWeeklyWeather = Entity.UseCase.AllWeatherData.WeeklyWeatherDetail
    
    // MARK: - Presentation
    
    typealias PresentationCurrentWeather = Presentation.AllWeather.CurrentWeatherModel
    typealias PresentationLocation = Presentation.AllWeather.CurrentWeatherModel.Location
    typealias PresentationCommonWeather = Presentation.AllWeather.CommonWeather
    typealias PresentationWeeklyWeather = Presentation.AllWeather.WeeklyWeatherModel
}

// MARK: - private

private extension MainWeatherViewModel {
    func convertToPresentationCurrentWeather(from currentWeather: EntityCurrentWeather,
                                             with location: EntityLocation) -> PresentationCurrentWeather {
        let location = PresentationLocation(city: location.city, district: location.district)
        let weather = PresentationCommonWeather.Weather(main: currentWeather.weather.main,
                                                        description: currentWeather.weather.description,
                                                        iconData: currentWeather.weather.iconData)
        let temperature = PresentationCommonWeather.TemperatureDetail(
            temperature: currentWeather.temperatureDetail.temperature,
            feelsLikeTemperature: currentWeather.temperatureDetail.feelsLikeTemperature,
            minimumTemperature: currentWeather.temperatureDetail.minimumTemperature,
            maximumTemperature: currentWeather.temperatureDetail.maximumTemperature
        )
        
        return .init(location: location,
                     weather: weather,
                     temperaturDetail: temperature,
                     dataTime: currentWeather.dataTime)
    }
    
    func converToPresentaionWeeklyWeather(from weeklyWeather: EntityWeeklyWeather) -> PresentationWeeklyWeather {
        let list: [PresentationWeeklyWeather.List] = weeklyWeather.list.map {
            let weather = PresentationCommonWeather.Weather(main: $0.weather.main,
                                                            description: $0.weather.description,
                                                            iconData: $0.weather.iconData)
            let temperature = PresentationCommonWeather.TemperatureDetail(temperature: $0.temperatureDetail.temperature,
                                                                          feelsLikeTemperature: $0.temperatureDetail.feelsLikeTemperature,
                                                                          minimumTemperature: $0.temperatureDetail.minimumTemperature,
                                                                          maximumTemperature: $0.temperatureDetail.maximumTemperature)
            return .init(dataTime: $0.dataTime,
                         weather: weather,
                         temperature: temperature)
        }
        return .init(list: list)
    }
}
