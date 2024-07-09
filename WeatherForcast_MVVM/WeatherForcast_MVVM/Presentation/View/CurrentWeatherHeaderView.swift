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
}
