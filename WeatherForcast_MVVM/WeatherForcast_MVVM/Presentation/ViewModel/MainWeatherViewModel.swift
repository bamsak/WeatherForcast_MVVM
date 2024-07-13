//
//  MainWeatherViewModel.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

final class MainWeatherViewModel {
    private let fetchWeatherForCurrentUseCase: FetchWeatherForCurrentLocationUseCase
    private var weatherObservable: Observable<Presentation.AllWeather>?
    
    init(fetchWeatherForCurrentUseCase: FetchWeatherForCurrentLocationUseCase) {
        self.fetchWeatherForCurrentUseCase = fetchWeatherForCurrentUseCase
    }
    
    func fetchWeather() -> Observable<Presentation.AllWeather> {
        let observable = Observable.create { observer in
            Task { [weak self] in
                guard let self = self else { return }
                do {
                    let weatherData = try await self.fetchWeatherForCurrentUseCase.excute()
                    let presentaionWeather = self.convertToPresentationWeatherModel(with: weatherData)
                    observer.onNext(presentaionWeather)
                } catch {
                    observer.onError(error)
                }
            }
            return ConcreteDispose {
                observer.removeAction?()
            }
        }
        self.weatherObservable = observable
        return observable
    }
    
    func updateWeather(_ uiUpdateHandler: @escaping @MainActor () -> Void) {
        Task {
            do {
                let weatherData = try await fetchWeatherForCurrentUseCase.excute()
                let presentaionWeather = self.convertToPresentationWeatherModel(with: weatherData)
                weatherObservable?.emit(.onNext(presentaionWeather))
                await uiUpdateHandler()
            } catch {
                weatherObservable?.emit(.onError(error))
                await uiUpdateHandler()
            }
        }
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
    typealias PresentationCommonWeather = Presentation.AllWeather.CommonWeather
    typealias PresentationWeeklyWeather = Presentation.AllWeather.WeeklyWeatherModel
}

// MARK: - private

private extension MainWeatherViewModel {
    func convertToPresentationWeatherModel(with allWeather: Entity.UseCase.AllWeatherData) -> Presentation.AllWeather {
        let currentWeather = convertToPresentationCurrentWeather(from: allWeather.currentWeather, with: allWeather.location)
        let weeklyWeather = converToPresentaionWeeklyWeather(from: allWeather.weeklyWeather)
        
        return .init(currentWeather: currentWeather, weeklyWeather: weeklyWeather)
    }
    
    func convertToPresentationCurrentWeather(from currentWeather: EntityCurrentWeather,
                                             with location: EntityLocation) -> PresentationCurrentWeather {
        let location = convertToLocationText(location)
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
    
    func convertToLocationText(_ location: EntityLocation) -> String? {
        guard let city = location.city
        else {
            return nil
        }
        guard let district = location.district
        else {
            return city
        }
        return city + " \(district)"
    }
    
    func converToPresentaionWeeklyWeather(from weeklyWeather: EntityWeeklyWeather) -> PresentationWeeklyWeather {
        let list: [PresentationWeeklyWeather.List] = weeklyWeather.list.map {
            let weather = PresentationCommonWeather.Weather(main: $0.weather.main,
                                                            description: $0.weather.description,
                                                            iconData: $0.weather.iconData)
            let temperature = PresentationCommonWeather.TemperatureDetail(
                temperature: $0.temperatureDetail.temperature,
                feelsLikeTemperature: $0.temperatureDetail.feelsLikeTemperature,
                minimumTemperature: $0.temperatureDetail.minimumTemperature,
                maximumTemperature: $0.temperatureDetail.maximumTemperature
            )
            
            return .init(dataTime: $0.dataTime,
                         weather: weather,
                         temperature: temperature)
        }
        return .init(list: list)
    }
}
