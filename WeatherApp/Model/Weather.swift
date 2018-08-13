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
    static let kSecondsToExpire : TimeInterval = 86400 // Seconds per day: 86400
    
    let currentCondition : String
    let temperature : Double
    let pressure: Double
    let humidity: Int
    let windSpeed: Double
    let windDeg: Int
    let iconID: String
    
    let timestamp: TimeInterval
    
    func iconURLString() -> String {
        return "\(Weather.kBaseIconURL)\(iconID)\(Weather.kIconFileExtension)"
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
        
        guard
            let main = json["main"] as? [String:AnyObject],
            let weather = json["weather"]?[0] as? [String:AnyObject],
            let wind = json["wind"] as? [String: AnyObject],
            let temperature = main["temp"] as? Double,
            let currentCondition = weather["main"] as? String,
            let iconID = weather["icon"] as? String,
            let humidity = main["humidity"] as? Int,
            let pressure = main["pressure"] as? Double,
            let windSpeed = wind["speed"] as? Double
        else { return nil }
        let windDeg = wind["deg"] as? Int ?? 90 // Sometimes the server don't send this value
        
        let timestamp = Date.timeIntervalSinceReferenceDate
        let updatedWeather = Weather(currentCondition: currentCondition, temperature: temperature, pressure: pressure, humidity: humidity, windSpeed: windSpeed, windDeg: windDeg, iconID: iconID, timestamp: timestamp)
        updatedWeather.save()
        return updatedWeather
    }
}
