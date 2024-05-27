//
//  LocationService.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/24/24.
//

import CoreLocation

final class LocationService: NSObject {
    private let manager: CLLocationManager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocationCoordinate2D, Error>?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LocationService: LocationDataProvidable {    
    func fetchCoordinate() async throws -> CLLocationCoordinate2D {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            self?.continuation = continuation
            self?.manager.startUpdatingLocation()
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined, .denied:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            return
        default:
            handleContinuation(withError: LocationError.unknownAuthorizationStatusError)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last
        else {
            handleContinuation(withError: LocationError.notFoundLocation)
            return
        }
        handleContinuation(withCoordinate: location.coordinate)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - Private

private extension LocationService {
    func handleContinuation(withError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
    
    func handleContinuation(withCoordinate value: CLLocationCoordinate2D) {
        continuation?.resume(returning: value)
        continuation = nil
    }
}
