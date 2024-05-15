//
//  APIService.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/14/24.
//

import Foundation

final class APIService {
    private let networkService: NetworkService
    private let decoder: JSONDecoder
    
    init(networkService: NetworkService, decoder: JSONDecoder = JSONDecoder()) {
        self.networkService = networkService
        self.decoder = decoder
    }
    
    func excute<T: Decodable>(with endPoint: APIEndPoint) async throws -> T {
        let request = try endPoint.urlRequest()
        let data = try await networkService.fetchData(request)
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}
