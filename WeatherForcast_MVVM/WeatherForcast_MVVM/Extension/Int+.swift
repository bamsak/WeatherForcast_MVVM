//
//  Int+.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

import Foundation

extension Int {
    func toFormattedDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return DateFormatter.krLocale.string(from: date)
    }
}
