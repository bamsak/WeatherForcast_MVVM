//
//  Cacheable.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 6/13/24.
//

import Foundation

protocol Cacheable {
    func fetchCachedData(with key: String) -> Data?
    func storeCacheData(_ data: Data, for key: String)
}
