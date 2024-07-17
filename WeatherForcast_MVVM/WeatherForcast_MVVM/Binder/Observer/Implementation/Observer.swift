//
//  Observer.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/3/24.
//

import Foundation

final class Observer<Element> {
    let id: UUID = UUID()
    
    private let eventHandler: (Event<Element>) -> Void
    private(set) var removeAction: (() -> Void)?
    
    init(eventHandler: @escaping (Event<Element>) -> Void) {
        self.eventHandler = eventHandler
    }
    
    func configureRemoveAction(_ handler: @escaping () -> Void) {
        removeAction = handler
    }
}

extension Observer: ObserverType {
    func on(event: Event<Element>) {
        eventHandler(event)
    }
}
