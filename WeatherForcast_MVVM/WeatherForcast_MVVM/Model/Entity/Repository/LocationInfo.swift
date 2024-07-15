//
//  LocationInfo.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/4/24.
//

extension Entity.Repository {
    struct LocationInfo {
        let city: String?
        let district: String?
        let coordinate: Coordinate
        
        init(city: String?,
             district: String?,
             latitude: Double,
             longitude: Double) {
            self.city = city
            self.district = district
            self.coordinate = Coordinate(latitude: latitude, longitude: longitude)
        }
    }
}

extension Entity.Repository.LocationInfo {
    struct Coordinate {
        let latitude: Double
        let longitude: Double
    }
    
    func asUseCaseEntity() -> Entity.UseCase.AllWeatherData.LocationDetail {
        return .init(city: self.city, district: self.district)
    }
}
