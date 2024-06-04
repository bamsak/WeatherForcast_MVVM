//
//  LocationRepository.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/4/24.
//

protocol LocationRepository {
    func fetchLocation() async throws -> Entity.Repository.LocationInfo
}
