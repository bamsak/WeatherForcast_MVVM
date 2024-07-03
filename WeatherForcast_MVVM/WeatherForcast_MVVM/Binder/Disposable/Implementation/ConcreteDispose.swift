//
//  ConcreteDispose.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/3/24.
//

struct ConcreteDispose: Disposable {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    func dispose() {
        action()
    }
}
