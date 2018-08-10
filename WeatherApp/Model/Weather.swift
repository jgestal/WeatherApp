//
//  Weather.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 8/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import Foundation

struct Weather: Codable {
    
    static let kLastWeatherUpdate = "kLastWeatherUpdate"
    static let kBaseIconURL = "http://openweathermap.org/img/w/"
    static let kIconFileExtension = ".png"
    static let kDateFormat = "HH:mm @ yyyy-MM-dd"
    static let kSecondsToExpire : TimeInterval = 86400 // Seconds per day: 86400
    
    let currentCondition : String
    let temperature : Double
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let windDeg: Int
    let iconID: String
    
    let timestamp: TimeInterval
    
    func iconURLString() -> String {
        return "\(Weather.kBaseIconURL)\(iconID)\(Weather.kIconFileExtension)"
    }
    
    func dateString() -> String {
        let date = Date.init(timeIntervalSinceReferenceDate: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Weather.kDateFormat
        return dateFormatter.string(from: date)
    }
    
    func windDirection() -> String {
        if windDeg >= 30 && windDeg < 60 {
            return "North West"
        }
        else if windDeg >= 60 && windDeg < 120 {
            return "North"
        }
        else if windDeg >= 120 && windDeg < 150 {
            return "North East"
        }
        else if windDeg >= 150 && windDeg < 210 {
            return "East"
        }
        else if windDeg >= 210 && windDeg < 240 {
            return "South East"
        }
        else if windDeg >= 240 && windDeg < 300 {
            return "South"
        }
        else if windDeg >= 300 && windDeg < 330 {
            return "South West"
        }
        else {
            return "West"
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            UserDefaults.standard.set(encoded, forKey: Weather.kLastWeatherUpdate)
        }
    }
    
    func hasExpired() -> Bool {
        let now = Date.timeIntervalSinceReferenceDate
        if now - timestamp < Weather.kSecondsToExpire {
            return false
        } else {
            return true
        }
    }
    
    static func lastWeatherUpdate() -> Weather? {
        let decoder = JSONDecoder()
        
        guard
            let data = UserDefaults.standard.value(forKey: Weather.kLastWeatherUpdate) as? Data,
            let weather = try? decoder.decode(Weather.self, from: data)
        else { return nil }
        
        return weather.hasExpired() ? nil : weather
    }
    
    static func weatherFromJSON(json: [String : AnyObject]) -> Weather? {
        
        //print(json)        
        guard
            let main = json["main"] as? [String:AnyObject],
            let weather = json["weather"]?[0] as? [String:AnyObject],
            let wind = json["wind"] as? [String: AnyObject],
            
            let temperature = main["temp"] as? Double,
            let currentCondition = weather["main"] as? String,
            let iconID = weather["icon"] as? String,
            let humidity = main["humidity"] as? Int,
            let pressure = main["pressure"] as? Int,
            let windSpeed = wind["speed"] as? Double,
            let windDeg = wind["deg"] as? Int
        else { return nil }
        
        let timestamp = Date.timeIntervalSinceReferenceDate
        let updatedWeather = Weather(currentCondition: currentCondition, temperature: temperature, pressure: pressure, humidity: humidity, windSpeed: windSpeed, windDeg: windDeg, iconID: iconID, timestamp: timestamp)
        updatedWeather.save()
        return updatedWeather
    }
}
