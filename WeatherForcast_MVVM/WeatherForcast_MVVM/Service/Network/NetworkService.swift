//
//  NetworkService.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/12/24.
//

import Foundation

final class NetworkService {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(_ urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: urlRequest, delegate: nil)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode
        else {
            throw NetworkError.failedResponseCasting
        }
        if let httpError = NetworkError.HTTPError(statusCode: statusCode) {
            throw httpError
        }
        return data
    }
}
