//
//  DefaultImageDataRepostory.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/28/24.
//

import Foundation

final class DefaultImageDataRepostory {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultImageDataRepostory: WeatherIconDataRepository {
    func fetchIconData(_ iconName: String) async throws -> Data {
        let request = try OpenWeatherEndPoint.icon(name: iconName).urlRequest()
        let iconData = try await networkService.fetchData(request)
        return iconData
    }
}
