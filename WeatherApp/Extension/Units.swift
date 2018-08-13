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

extension Int {
    func windDirection() -> String {
        if self >= 30 && self < 60 {
            return "North East"
        }
        else if self >= 60 && self < 120 {
            return "North"
        }
        else if self >= 120 && self < 150 {
            return "North West"
        }
        else if self >= 150 && self < 210 {
            return "West"
        }
        else if self >= 210 && self < 240 {
            return "South West"
        }
        else if self >= 240 && self < 300 {
            return "South"
        }
        else if self >= 300 && self < 330 {
            return "South East"
        }
        else {
            return "East"
        }
    }
}

extension TimeInterval {
    func dateString() -> String {
        let kDateFormat = "HH:mm @ yyyy-MM-dd"
        let date = Date.init(timeIntervalSinceReferenceDate: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormat
        return dateFormatter.string(from: date)
    }
}

