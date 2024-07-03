//
//  ObserverType.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/3/24.
//

protocol ObserverType {
    associatedtype Element
    
    func on(event: Event<Element>)
}

extension ObserverType {
    func onNext(_ element: Element) {
        on(event: .onNext(element))
    }
    
    func onError(_ error: Error) {
        on(event: .onError(error))
    }
}
