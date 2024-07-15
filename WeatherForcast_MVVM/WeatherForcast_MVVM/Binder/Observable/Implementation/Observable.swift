//
//  Observable.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/1/24.
//

import Foundation

final class Observable<Element> {
    private var observers = [UUID: Observer<Element>]()
    private let subscribeHandler: (Observer<Element>) -> Disposable
    
    init(subscribeHandler: @escaping (Observer<Element>) -> Disposable) {
        self.subscribeHandler = subscribeHandler
    }
    
    func emit(_ event: Event<Element>) {
        for observer in observers.values {
            observer.on(event: event)
        }
    }
}

extension Observable: ObservableType {
    func subscribe(_ observer: Observer<Element>) -> Disposable {
        observers[observer.id] = observer
        observer.removeAction = { [weak self] in
            self?.observers.removeValue(forKey: observer.id)
        }
        return subscribeHandler(observer)
    }
}
