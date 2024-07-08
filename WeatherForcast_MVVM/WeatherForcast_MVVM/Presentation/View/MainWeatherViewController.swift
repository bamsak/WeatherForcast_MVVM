//
//  ViewController.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 4/29/24.
//

import UIKit

final class MainWeatherViewController: UIViewController {
    private let mainWeatherViewModel: MainWeatherViewModel
    
    init(mainWeatherViewModel: MainWeatherViewModel) {
        self.mainWeatherViewModel = mainWeatherViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

