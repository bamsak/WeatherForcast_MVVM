//
//  WeeklyWeatherCell.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/9/24.
//

import UIKit

final class WeeklyWeatherCell: UICollectionViewCell {
    
    // MARK: - UIComponents
    
    private let dateTextLabel = UILabel().then { $0.translatesAutoresizingMaskIntoConstraints = false }
    private let temperatureLabel = UILabel().then { $0.translatesAutoresizingMaskIntoConstraints = false }
    private let weatherIconView = UIImageView().then { $0.translatesAutoresizingMaskIntoConstraints = false }
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    func updateUI(_ weeklyWeatherList: WeeklyWeatherList) {
        dateTextLabel.text = weeklyWeatherList.dateText
        temperatureLabel.text = weeklyWeatherList.temperatureDetail.temperature
        weatherIconView.image = UIImage(data: weeklyWeatherList.weather.iconData)
    }
}


// MARK: - Type Ailas

extension WeeklyWeatherCell {
    typealias WeeklyWeatherList = Presentation.AllWeather.WeeklyWeatherModel.List
}

// MARK: - Auto Layout

private extension WeeklyWeatherCell {
    func configureCell() {
        contentView.addSubview(dateTextLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherIconView)
        
        setConstraintsDateTextLabel()
        setConstraintsTemperatureLabel()
        setConstraintsWeatherIconView()
    }
    
    func setConstraintsDateTextLabel() {
        NSLayoutConstraint.activate([
            dateTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setConstraintsTemperatureLabel() {
        NSLayoutConstraint.activate([
            temperatureLabel.trailingAnchor.constraint(equalTo: weatherIconView.leadingAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setConstraintsWeatherIconView() {
        NSLayoutConstraint.activate([
            weatherIconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherIconView.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherIconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherIconView.widthAnchor.constraint(equalTo: weatherIconView.heightAnchor)
        ])
    }
}
