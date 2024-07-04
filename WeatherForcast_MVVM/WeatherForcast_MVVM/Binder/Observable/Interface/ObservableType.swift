//
//  ObservableType.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/1/24.
//

protocol ObservableType: AnyObject {
    associatedtype Element
    
    func subscribe(_ observer: Observer<Element>) -> Disposable
    func asObservable() -> Observable<Element>
}
