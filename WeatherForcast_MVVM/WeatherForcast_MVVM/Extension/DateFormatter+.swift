//
//  DateFormatter+.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/7/24.
//

import Foundation

extension DateFormatter {
    static let krLocale: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd(E) HH시"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
