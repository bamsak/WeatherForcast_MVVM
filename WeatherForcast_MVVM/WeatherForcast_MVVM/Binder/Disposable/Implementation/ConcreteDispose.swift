//
//  ConcreteDispose.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/3/24.
//

struct ConcreteDispose {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
}

extension ConcreteDispose: Disposable {
    func dispose() {
        action()
    }
}
