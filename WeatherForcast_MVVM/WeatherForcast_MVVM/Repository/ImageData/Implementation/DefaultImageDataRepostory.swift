//
//  DefaultImageDataRepostory.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/28/24.
//

import Foundation

final class DefaultImageDataRepostory {
    private let networkService: NetworkService
    private let cacheService: Cacheable
    
    init(networkService: NetworkService, cacheService: Cacheable = CacheService.shared) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
}

extension DefaultImageDataRepostory: WeatherIconDataRepository {
    func fetchIconData(_ iconName: String) async throws -> Data {
        guard let cachedIconData = cacheService.fetchCachedData(with: iconName) 
        else {
            let request = try OpenWeatherEndPoint.icon(name: iconName).urlRequest()
            let iconData = try await networkService.fetchData(request)
            cacheService.storeCacheData(iconData, for: iconName)
            return iconData
        }
        return cachedIconData
    }
}
