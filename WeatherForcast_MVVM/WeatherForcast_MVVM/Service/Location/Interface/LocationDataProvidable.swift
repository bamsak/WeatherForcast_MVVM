//
//  LocationDataProvidable.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/25/24.
//

import CoreLocation

protocol LocationDataProvidable {
    func fetchCoordinate() async throws -> CLLocationCoordinate2D
    func fetchPlacemark() async throws -> CLPlacemark
}
