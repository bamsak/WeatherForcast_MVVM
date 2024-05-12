//
//  NetworkService.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/12/24.
//

import Foundation

final class NetworkService {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(_ urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: urlRequest)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode
        else {
            throw NetworkError.failedResponseCasting
        }
        guard (200..<300).contains(statusCode) 
        else {
            throw NetworkError.responseError(statusCode: statusCode)
        }
        return data
    }
}
