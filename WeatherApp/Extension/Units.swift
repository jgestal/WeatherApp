//
//  Units.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 8/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import Foundation

extension String {
    func celsiusUnits() -> String {
        return self + " °C"
    }
    func mphUnits() -> String {
        return self + " mph"
    }
}

extension Double {
    func kelvinToCelsius() -> Double {
        return self - 273.15
    }
}
