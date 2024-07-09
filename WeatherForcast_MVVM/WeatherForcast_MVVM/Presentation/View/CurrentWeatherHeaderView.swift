//
//  CurrentWeatherHeaderView.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/9/24.
//

import UIKit

final class CurrentWeatherHeaderView: UICollectionReusableView {
    
    // MARK: - UIComponents
    
    private let weatherIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let minMaxTemperatureLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private lazy var locationTemperaturStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationLabel, minMaxTemperatureLabel, currentTemperatureLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var mainHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weatherIconView, locationTemperaturStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeaderView()
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
    func configureHeaderView() {
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
