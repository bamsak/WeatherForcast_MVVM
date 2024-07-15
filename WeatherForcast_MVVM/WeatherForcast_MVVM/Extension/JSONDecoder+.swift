//
//  JSONDecoder+.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/20/24.
//

import Foundation

protocol DataDecodable {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: DataDecodable {
    
}
