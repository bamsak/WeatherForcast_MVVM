//
//  Then.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 7/10/24.
//

import Foundation

protocol Then { }

extension Then where Self: AnyObject {
    func then(_ handler: (Self) -> Void) -> Self {
        handler(self)
        return self
    }
}

extension NSObject: Then { }
