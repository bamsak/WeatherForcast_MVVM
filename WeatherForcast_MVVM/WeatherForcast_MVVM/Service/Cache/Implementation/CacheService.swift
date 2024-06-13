//
//  CacheService.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/13/24.
//

import Foundation

final class CacheService {
    private let storage = NSCache<NSString, NSData>()
    static let shared = CacheService()
    
    private init() { }
}

extension CacheService: Cacheable {
    func fetchCachedData(with key: String) -> Data? {
        let cacheKey = NSString(string: key)
        guard let cachedData = storage.object(forKey: cacheKey)
        else {
            return nil
        }
        return Data(referencing: cachedData)
    }
    
    func storeCacheData(_ data: Data, for key: String) {
        let cacheKey = NSString(string: key)
        let cacheData = NSData(data: data)
        storage.setObject(cacheData, forKey: cacheKey)
    }
}
