//
//  Observer.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/3/24.
//

import Foundation

final class Observer<Element> {
    let id: UUID = UUID()
    var removeAction: (() -> Void)?
    
    private let eventHandler: (Event<Element>) -> Void
    
    init(eventHandler: @escaping (Event<Element>) -> Void) {
        self.eventHandler = eventHandler
    }
}

extension Observer: ObserverType {
    func on(event: Event<Element>) {
        eventHandler(event)
    }
}
