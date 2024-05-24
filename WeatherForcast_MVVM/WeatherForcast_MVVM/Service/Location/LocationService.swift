//
//  LocationService.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/24/24.
//

import CoreLocation

final class LocationService: NSObject {
    private let manager: CLLocationManager = CLLocationManager()
    private var continueation: CheckedContinuation<CLLocationCoordinate2D, Error>?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func fetchCoordinate() async throws -> CLLocationCoordinate2D {
        return try await withCheckedThrowingContinuation { continueation in
            self.continueation = continueation
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined, .denied:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last
        else {
            return
        }
        continueation?.resume(returning: location.coordinate)
        continueation = nil
    }
}



