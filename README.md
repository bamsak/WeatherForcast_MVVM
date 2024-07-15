# WeatherForcast_ MVVM

## **📋** 개요

OpenWeatherAPI를 활용한 사용자 위치기반 날씨 앱. (1인 개발)

기존에 진행했던 MVC + Delegate Pattern으로 진행한 날씨 앱 프로젝트를
MVVM + Clean Architecture + DiffableDataSource를 활용한 CollectionView로 새로 구현한 프로젝트입니다.

[프로젝트 진행과정 정리 노트](https://www.notion.so/WeatherForcast_MVVM-204d1bfcce8b4e39b27e32903ee3ec15?pvs=21) <- 클릭하시면 프로젝트 진행하며 정리한 내용을 보실 수 있습니다.

## 💻 주요 구현 사항

- CheckedContiuation을 활용한 CLLocationManagerDelegate의 비동기 코드 Swift Concurrency코드로 변환하여 활용.
- async let과 TaskGroup을 활용하여 날씨 데이터와 날씨 아이콘 네트워크 통신 병렬 처리.
- RxSwift를 참고한 Observable + Observer + Disposable을 구현으로 ViewModel과 View 간 데이터 바인딩.

### 프로젝트 구조
<img width="2086" alt="Presentation_구조_2" src="https://github.com/user-attachments/assets/61063296-d8a1-4f54-a2de-001286846893">



## 🔫 Trouble Shooting (클릭하여 내용을 펼쳐 볼 수 있습니다.)

<details>
<summary><strong>CheckedContinuation를 통해, CLLocationManagerDelegate의 비동기로 동작하는 메소드 Swift ConCurrency(await async) 코드로 활용</strong></summary>

[해당 TroubleShooting 정리 노트](https://www.notion.so/SwiftConcurrency-CLLocationManager-CheckedContinuation-1-2a61e8cf31584af39b3b3f45d111b9ea?pvs=21)

CLLocationManagerDelegate의 메소드에서 현재 위치를 객체 외부에서 활용하기 위해, DelegatePattern이나 didSet + Completion Handler의 활용을 생각해봤습니다.
`DelegatePattern`을 활용하여 현재위치를 통해 API통신을 할 경우,` Location을 관리하는 객체에서 API 통신도 해줘야 하기 때문에 해당 객체의 책임이 너무 커진다고 생각`했고, `didSet + Completion Handler`를 활용한다면, `코드의 뎁스가 깊어지고 계속해서 이어지는 call back 함수로 인해 코드의 가독성을 저하` 시킬 것 같다는 생각을 했습니다.

또한, API 통신을 위해 구현된 코드가 SwiftConcurrency로 작성되어 있었으며, 이와 함께 활용할 방법을 생각해 보았습니다.
그리 하여, 공식문서에서 `CheckedContinuation`라는 것을 찾아보게 되었고, 이를 활용하여 `현재 위치를 가져오는 비동기 메소드와 기존의 API 통신을 위해 구현된 코드를 Swift Concurrency 코드로 활용`할 수 있었습니다.

- 코드 구현
    
    ```swift
    final class LocationService: NSObject {
    		// 생략..
        private var continuation: CheckedContinuation<CLLocation, Error>?
    		// 생략..
    }
    
    extension LocationService: CLLocationManagerDelegate {
    		// 생략..
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last
            else {
                handleContinuation(withError: LocationError.notFoundLocation)
                return
            }
            handleContinuation(withLocation: location)
            manager.stopUpdatingLocation()
        }
    }
    
    // Continuation
    private extension LocationService {
        func fetchLocation() async throws -> CLLocation {
            return try await withCheckedThrowingContinuation { [weak self] continuation in
                self?.continuation = continuation
                self?.manager.startUpdatingLocation()
            }
        }
        
        func handleContinuation(withError error: Error) {
            continuation?.resume(throwing: error)
            continuation = nil
        }
        
        func handleContinuation(withLocation value: CLLocation) {
            continuation?.resume(returning: value)
            continuation = nil
        }
    }
    // 외부에서 호출될 코드.
    **extension LocationService: LocationDataProvidable {
        func fetchPlacemark() async throws -> CLPlacemark {
            let location = try await fetchLocation()
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            guard let placemark = placemarks.last
            else {
                throw LocationError.notFoundPlacemark
            }
            return placemark
        }
    }**
    ```
</details>

<details>
<summary> <strong>async let과 TaskGroup을 활용하여 날씨 데이터와 날씨 아이콘 네트워크 통신 병렬 처리. </strong></summary>

[해당 TroubleShooting 정리 노트](https://www.notion.so/async-let-throwinTaskGroup-b68ca74f831e48b6be20321141cef1b7?pvs=21)

API 명세에 따르면 날씨 데이터를 받아온 뒤, 받아온 날씨 데이터의 icon이름을 가지고 다시 한번 네트워크 통신을 통해, 날씨 icon에 관련된 Data를 받아와야합니다.

이를 구현된 코드로 하나의 Task에서 진행 할 경우 순서는
1. 현재 날씨 받아오기
2. 주간 날씨 받아오기
3. 현재 날씨 icon의 Data 받아오기
4. 주간 날씨 icon의 Data 받아오기

위와 같이 `하나하나 순차적으로 실행되는데, 이는 매우 비효율적이라고 판단`이 들었습니다. 특히 주간 **날씨 icon의 경우, api에서 제공되는 Data가 40개**정도 되는데, 이를 하나하나 순차적으로 iconData처리를 해줘야 하는데, 만약 `40개가 아닌 무수히 많은 데이터라면 매우 비효율적이라는 생각`이 들었습니다.

이를 해소하기 위해 `async let`과 `TaskGroup을 활용`하여 `병렬`로 동작하도록 처리를 했습니다.

- 코드 구현
    
    ```swift
    private extension ConcreteFetchWeatherForCurrentLocationUseCase {
    		// async let을 활용한 날씨 데이터 병렬로 통신
        func fetchWeatherData(with coordinate: Coordinate) async throws -> AllWeatherResult {
            async let currentWeather = currentWeatherRepository.fetchCurrentWether(latitude: coordinate.latitude,
                                                                                   longitude: coordinate.longitude)
            async let weeklyWeather = weeklyWeatherRepository.fetchWeeklyWeather(latitude: coordinate.latitude,
                                                                                 longitude: coordinate.longitude)
            return try await (currentWeather, weeklyWeather)
        }
        
        // TaskGroup을 활용한 주간 날씨의 icon을 위한 API 통신 병렬로 처리
        func convertToWeeklyWeatherDetail(_ repositoryListEntities: [RepositoryListEntity]) async throws ->
        Entity.UseCase.AllWeatherData.WeeklyWeatherDetail {
            var useCaseListEntities = [UseCaseListEntity](repeating: UseCaseListEntity(), count: repositoryListEntities.count)
            
            try await withThrowingTaskGroup(of: (Int, UseCaseListEntity).self) { [weak self] group in
                guard let self = self else { throw BindingError.failedSelfBinding }
                repositoryListEntities.enumerated().forEach { index, item in
                    group.addTask {
                        let iconData = try await self.weatherIconDataRepository.fetchIconData(item.weather.icon)
                        return (index, item.asUseCaseEntity(with: iconData))
                    }
                }
                
                for try await (index, list) in group {
                    useCaseListEntities[index] = list
                }
            }
            
            return .init(list: useCaseListEntities)
        }
        
        func convertToCurrentWEatherDetail(_ repositoryCurrentWeatherEntity: Entity.Repository.CurrentWeatherInfo) async throws -> Entity.UseCase.AllWeatherData.CurrentWeatherDetail {
            let iconData = try await weatherIconDataRepository.fetchIconData(repositoryCurrentWeatherEntity.weather.icon)
            return .init(weather: repositoryCurrentWeatherEntity.weather.asUseCaseEntity(with: iconData),
                         temperatureDetail: repositoryCurrentWeatherEntity.temperatureInfo.asUseCaseEntity(),
                         dataTime: repositoryCurrentWeatherEntity.dataTime)
        }
    }
    
    // 호출부
    extension ConcreteFetchWeatherForCurrentLocationUseCase: FetchWeatherForCurrentLocationUseCase {
        func excute() async throws -> Entity.UseCase.AllWeatherData {
            let location = try await locationRepository.fetchLocation()
            // 전체 날씨 데이터 가져옴
            let weatherData = try await fetchWeatherData(with: location.coordinate)
            /* 날씨 데이터를 가져온 후, 날씨 아이콘을 포함한 현재 및 주간 날씨 Entity로 변환하는 코드 async let으로 병렬처리
    		       내부에서 TaskGroup으로 주간 날씨 병렬 처리.*/
            async let weeklyWeatheerDetail = convertToWeeklyWeatherDetail(weatherData.weeklyWeather.list)
            async let currentWeatherDetail = convertToCurrentWEatherDetail(weatherData.currentWeather)
    
            return try await .init(location: location.asUseCaseEntity(),
                         currentWeather: currentWeatherDetail,
                         weeklyWeather: weeklyWeatheerDetail)
        }
    }
    ```
    
    - TaskGroup을 사용할 경우, 비동기로 처리되는 동작이 `처리가 완료되는 순서대로 배열에 append`를 해주기 때문에, 이를 `sort`를 해줄까 고민했지만 `이에 대해 추가적인 시간이 더 든다고 판단`하여, **기존의 배열 크기만큼 배열을 선언해주고 enumerated로 index**를 뽑아, 해당 **index에 값을 할당**해주도록 했습니다.
</details>
<details>
<summary><strong> MVVM 패턴의 DataBinding을 위해, RxSwift를 참고한 Observable, Observer, Disposable 구현.</strong></summary>

[해당 TroubleShooting 정리 노트](https://www.notion.so/RxSwift-Observable-7c7dae485db440da90ef8a42e5ccdfd4?pvs=21)

이전에 다른 프로젝트에서 진행했던 Closure + didSet 방식 이외에 새로운 방식으로 DataBinding을 해보기 위해, **RxSwift라이브러리를 참고**하여, `Observable`, `Observer`, `Disposable`을 구현했습니다.

- **Event**
    
    ```swift
    enum Event<Element> {
        case onNext(Element)
        case onError(Error)
    }
    ```
    
    Observer에게 전달 될 이벤트 입니다.
    
- **OberserverType, Observer**
    
    ```swift
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
    ```
    
    - Observer의 관리를 위해 고유 값 UUID와 구독 시작 시, 받은 Event로 Observer가 처리할 동작을 Observer 초기화 시, 지정하도록 구현했습니다.
- **ObservableType, Observable**
    
    ```swift
    protocol ObservableType: AnyObject {
        associatedtype Element
        
        func subscribe(_ observer: Observer<Element>) -> Disposable
    }
    
    extension ObservableType {
        func subscribe(_ handler: @escaping (Event<Element>) -> Void) -> Disposable {
            let observer = Observer<Element> { event in
                handler(event)
            }
            return self.subscribe(observer)
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
            return self.subscribe(observer)
        }
    }
    
    extension ObservableType {
        static func create(_ subscribe: @escaping (Observer<Element>) -> Disposable) -> Observable<Element> {
            return Observable(subscribeHandler: subscribe)
        }
    }
    
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
    ```
    
    - create 메소드로 Oservable 생성 시, 구독이 시작되었을 때, Observer에게 값을 emit하기 위한 handler를 지정하여, Observer에게 때에 맞는 Event를 전달하도록 구현했습니다.
    - 구독 시작시 ObservableType에 기본 구현된 subscribe 메소드의 파라미터로 Observer의 eventHandler를 지정해주어 Observer를 초기화 해준 뒤, Observable 구현체의 subscribe 메소드를 호출하여 Dictionary로 Observer 저장, Observable 초기화 시 지정될 subscribeHandler를 호출하여 Observer에게 값을 발행해주고 Disposable을 반환하도록 구현 했습니다.
- **Disposable**
    
    ```swift
    protocol Disposable {
        func dispose()
    }
    
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
    ```
    
    - Disposable 객체 초기화 시, Observable의 Observer Dictionary에서 해당 Observer를 제거할 수 있도록 action으로 지정해주도록 구현했습니다.
</details>

## 📱 구현 영상
| 사용자 위치 권한 확인 후 날씨 정보 | 날씨 새로고침(시뮬레이터 Location 변경) |
|--------|--------|
| <img src=https://github.com/user-attachments/assets/eafa81eb-9426-470c-ba85-1c3ebccc3d9a width="300" height="650">| <img src=https://github.com/user-attachments/assets/d9d483fb-8d8c-4d90-a7f7-312c4ddf8fc5 width="300" height="650"> |


## 📁 각 Layer 설명

### Presention

---

- View
    - DiffableDataSource와 Compositional Layout을 활용한 Header 및 List로 CollectionView를 구성하여, 사용자에게  날씨 정보를 보여줍니다.
- ViewModel
    - UseCase에서 반환된 Entity를 View에 보여주기 위한 PresentaionModel로 매핑하여 View에 DataBinding을 해줍니다.
- PreSentationModel
    - View에 보여질 모델을 담당합니다.

### UseCase

---

- ConcreteFetchWeatherForCurrentLocationUseCase
    - 현재 위치 기반으로 각 Repository에서 반환된 데이터를 DomainModel로 매핑해주는 역할을 합니다.
    - 매핑 과정에서 병렬처리와 같은 비즈니스 로직을 수행해주는 객체입니다.
- Entity
    - Repository에서 반환받은 각 Entity를 Domain Entity로 결합한 모델입니다.

### Repository

---

- Domain Layer(Entity or UseCase)와 Data Layer의 중간 다리 역할을 하며, 각 Service객체에서 받은 Data(ex: DTO)를 Repository에서 매핑하고, protocol로 추상화하여, UseCase가 DataLayer에 의존방향을 띄지않게 해줬습니다.
- 또한 Repository를 통해, Data를 가져오는 주체(Local / Remote)를 외부에서 알 수 없도록 해줄 수 있었습니다.

- WeatherIconDataRepository
    - NSCache로 이미지 캐싱을 구현하여, Repository 패턴을 통해, imageData를 Local에서 가져올지 Remote에서 가져올 지 외부에선 알지 못하도록 구현했습니다.
- LocationRepository
    - 현재 위치를 Domain Model로 매핑하여 반환해주는 Repository입니다.
- CurrentWeatherRepository, WeeklyWeatherRepository
    - 현재 날씨, 주간 날씨를 Domain Model로 매핑하여 반환해주는 Repository입니다.

### Service (Infra, Data)

---

- APIService
    - 네트워크 통신 객체와 JSONDecoder를 통해, 네트워크 결과를  DTO 타입으로 반환해주는 객체입니다.
- NetworkService
    - URLSession을 통해 실질 네트워크 통신을 해주는 역할을 하는 객체입니다.
- APIEndPoint
    - API통신에 필요한 EndPoint를 프로토콜로 추상화 했습니다.
    - 해당 프로토콜을 채택한 객체는 필요한 요구사항을 정의해주어야 하며,
    - protocol extension의 기본 구현을 통해, 네트워크 통신에 필요한 URLRequest로 변환해주는 메소드를 구현했습니다.
- LocationService
    - CLLocationManager와 CLLocationManagerDelegate로 현재 위치를 받아와 외부로 반환해주는 객체입니다.
- CacheService
    - 날씨 iconData에 대해 Memory Cache를 해주는 객체 입니다.

### Model (Presentaion, DTO, Entity)
---
- DTO
    - 네트워크 통신으로 받은 데이터를 JSONDecoder를 통해 반환될 DTO 타입입니다. (Data Layer)
- Entity (Repository)
    - Repository가 반환할 Entity로 외부 Layer(Domain, Presentation)에서 Data Layer로의 의존성을 띄지 않도록 해당 Entity로 변환하여 반환해줍니다.
- Entity (UseCase)
    - UseCase가 반환할 Entity로 Repository에서 반환된 Entity를 조합하여 필요한 부분에 반환될 수 있도록 합니다.
- Presentation
    - View에 보여질 Model로 기존에 Entity에서 해당 뷰에 보여지기 위한 타입이나 내용으로 변환되어 해당 모델로 반환 해줍니다.

### ETC.

---

- Then
    - UI Component의 속성을 지정해주기 편하게 하기 위해 Then 라이브러리를 참고하여 구현했습니다.
- AppEnvironment
    - Factory 패턴을 활용하여, rootView를 구성하는 데에 필요한 요소들을 의존성 주입을 통해 ViewController를 반환해주는 역할을 해줍니다.

## 지난 PR 기록

[[PR] DTO 구현](https://github.com/bamsak/WeatherForcast_MVVM/pull/1)

[[PR] Network Layer 구현](https://github.com/bamsak/WeatherForcast_MVVM/pull/2)

[[PR] CoreLocation](https://github.com/bamsak/WeatherForcast_MVVM/pull/3)

[[PR] Repository 구현](https://github.com/bamsak/WeatherForcast_MVVM/pull/3) 

[[PR] Refactor Location Service](https://github.com/bamsak/WeatherForcast_MVVM/pull/5)

[[PR] NSCache를 활용한 Memory Cache 구현](https://github.com/bamsak/WeatherForcast_MVVM/pull/6)

[[PR] UseCase 구현](https://github.com/bamsak/WeatherForcast_MVVM/pull/7)

[[PR] Presentation Layer 구현](https://github.com/bamsak/WeatherForcast_MVVM/pull/8)
