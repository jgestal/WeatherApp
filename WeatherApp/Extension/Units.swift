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
    func fahrenheitUnits() -> String  {
        return self + " °F"
    }
    func mphUnits() -> String {
        return self + " mph"
    }
    func kmhUnits() -> String {
        return self + " km/h"
    }
}

extension Double {
    func kelvinToCelsius() -> Double {
        return self - 273.15
    }
    
    func kelvinToFahrenheit() -> Double {
        return self * 9 / 5 - 459.67
    }
    
    func mphToKmh() -> Double {
        return (self * 1.60934).rounded(toPlaces: 2)
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
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

