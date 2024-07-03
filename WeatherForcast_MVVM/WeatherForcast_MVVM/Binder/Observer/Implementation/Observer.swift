//
//  Observer.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/3/24.
//

import Foundation

final class Observer<Element> {
    private let eventHandler: (Event<Element>) -> Void
    var removeAction: (() -> Void)?
    let id: UUID = UUID()
    
    init(eventHandler: @escaping (Event<Element>) -> Void) {
        self.eventHandler = eventHandler
    }
}

extension Observer: ObserverType {
    func on(event: Event<Element>) {
        eventHandler(event)
    }
}
