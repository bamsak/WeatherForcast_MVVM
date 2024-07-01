//
//  Event.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/1/24.
//

enum Event<Element> {
    case onNext(Element)
    case onError(Error)
}
