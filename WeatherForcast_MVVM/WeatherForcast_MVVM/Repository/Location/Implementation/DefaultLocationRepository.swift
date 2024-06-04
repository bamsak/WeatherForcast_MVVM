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
        let coordinate = try await locationService.fetchCoordinate()
        let locationInfo = Entity.Repository.LocationInfo(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return locationInfo
    }
}
