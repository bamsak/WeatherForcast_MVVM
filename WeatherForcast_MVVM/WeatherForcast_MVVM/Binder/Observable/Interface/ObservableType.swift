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

extension ObservableType {
    func subscribe(_ handler: @escaping (Event<Element>) -> Void) -> Disposable {
        let observer = Observer<Element> { event in
            handler(event)
        }
        return self.asObservable().subscribe(observer)
    }
    
    func subscribe(onNext: ((Element) -> Void)? = nil, onError: ((Error) -> Void)? = nil) -> Disposable {
        let observer = Observer<Element> { event in
            switch event {
            case .onNext(let element):
                onNext?(element)
            case .onError(let error):
                if let onError = onError {
                    onError(error)
                }
            }
        }
        return self.asObservable().subscribe(observer)
    }
    
    func asObservable() -> Observable<Element> {
        return Observable.create { observer in
            self.subscribe(observer)
        }
    }
}

extension ObservableType {
    static func create(_ subscribe: @escaping (Observer<Element>) -> Disposable) -> Observable<Element> {
        return Observable(subscribeHandler: subscribe)
    }
}
