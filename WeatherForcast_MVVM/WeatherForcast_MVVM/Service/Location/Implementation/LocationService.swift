//
//  LocationService.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/24/24.
//

import CoreLocation

final class LocationService: NSObject {
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var continuation: CheckedContinuation<CLLocation, Error>?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LocationService: LocationDataProvidable {
    func fetchPlacemark() async throws -> CLPlacemark {
        let location = try await fetchLocation()
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        guard let placemark = placemarks.last
        else {
            throw LocationError.notFoundPlacemark
        }
        return placemark
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
        handleContinuation(withLocation: location)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - Private

private extension LocationService {
    func fetchLocation() async throws -> CLLocation {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            self?.continuation = continuation
            self?.manager.startUpdatingLocation()
        }
    }
    
    func handleContinuation(withError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
    
    func handleContinuation(withLocation value: CLLocation) {
        continuation?.resume(returning: value)
        continuation = nil
    }
}
