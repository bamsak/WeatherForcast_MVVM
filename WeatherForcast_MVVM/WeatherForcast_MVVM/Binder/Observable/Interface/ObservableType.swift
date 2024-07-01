//
//  ObservableType.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/1/24.
//

protocol ObservableType: AnyObject {
    associatedtype Element
    func subscribe(_ handler: @escaping (Event<Element>) -> Void) -> Disposable
}
