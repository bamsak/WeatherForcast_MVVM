//
//  MappingError.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 5/31/24.
//

enum MappingError<T>: Error {
    case failedToDomainModel(T.Type)
}
