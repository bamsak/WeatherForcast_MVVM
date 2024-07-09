//
//  CurrentWeatherHeaderView.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/9/24.
//

import UIKit

final class CurrentWeatherHeaderView: UICollectionReusableView {
    
    // MARK: - UIComponents
    
    private let weatherIconView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let locationLabel = UILabel()
    private let minMaxTemperatureLabel = UILabel()
    private let currentTemperatureLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .largeTitle)
    }
    private lazy var locationTemperaturStackView = UIStackView(arrangedSubviews: [
        locationLabel,
        minMaxTemperatureLabel,
        currentTemperatureLabel
    ]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
    }
    private lazy var mainHeaderStackView = UIStackView(arrangedSubviews: [
        weatherIconView,
        locationTemperaturStackView
    ]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 8
    }
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstratintsHeaderView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method

    func updateUI(with currentWeather: CurrentWeather) {
        weatherIconView.image = UIImage(data: currentWeather.weather.iconData)
        locationLabel.text = locationLabelText(currentWeather.location)
        minMaxTemperatureLabel.text = minMaxTemperatureLabelText(currentWeather.temperaturDetail)
        currentTemperatureLabel.text = currentWeather.temperaturDetail.temperature
    }
}

// MARK: - TypeAlias

extension CurrentWeatherHeaderView {
    typealias CurrentWeather = Presentation.AllWeather.CurrentWeatherModel
    typealias TemperatureDetail = Presentation.AllWeather.CommonWeather.TemperatureDetail
}

// MARK: - Private Method

private extension CurrentWeatherHeaderView {
    func locationLabelText(_ location: CurrentWeather.Location) -> String? {
        guard let city = location.city
        else {
            return nil
        }
        guard let district = location.district
        else {
            return city
        }
        return city + district
    }
    
    func minMaxTemperatureLabelText(_ temperature: TemperatureDetail) -> String {
        return "최저 \(temperature.minimumTemperature) 최고 \(temperature.maximumTemperature)"
    }
}


// MARK: - AutoLayout

private extension CurrentWeatherHeaderView {
    func setConstratintsHeaderView() {
        addSubview(mainHeaderStackView)
        
        NSLayoutConstraint.activate([
            mainHeaderStackView.topAnchor.constraint(equalTo: topAnchor),
            mainHeaderStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainHeaderStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainHeaderStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            weatherIconView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0)
        ])
    }
}
