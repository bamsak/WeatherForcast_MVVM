//
//  DefaultLocationRepository.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/4/24.
//

final class DefaultLocationRepository {
    private let locationService: LocationDataProvidable
    
    init(locationService: LocationDataProvidable) {
        self.locationService = locationService
    }
}

extension DefaultLocationRepository: LocationRepository {
    func fetchLocation() async throws -> Entity.Repository.LocationInfo {
        let placemark = try await locationService.fetchPlacemark()
        guard let coordinate = placemark.location?.coordinate 
        else {
            throw LocationError.notFoundLocation
        }
        let locationInfo = Entity.Repository.LocationInfo(city: placemark.locality,
                                                          district: placemark.subLocality,
                                                          latitude: coordinate.latitude,
                                                          longitude: coordinate.longitude)
        return locationInfo
    }
}
