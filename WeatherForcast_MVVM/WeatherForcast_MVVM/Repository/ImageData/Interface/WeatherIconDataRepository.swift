//
//  WeatherIconDataRepository.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/28/24.
//

import Foundation

protocol WeatherIconDataRepository {
    func fetchIconData(_ iconName: String) async throws -> Data
}
