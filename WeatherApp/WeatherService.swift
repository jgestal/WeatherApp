//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 8/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import Foundation
import CoreLocation

struct Weather {
    let currentCondition : String
    let temperature : Double
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let windDeg: Int
    
    static func weatherFromJSON(json: [String : AnyObject]) -> Weather? {
        
        //print(json)
        guard
            
            let main = json["main"] as? [String:AnyObject],
            let weather = json["weather"]?[0] as? [String:AnyObject],
            let wind = json["wind"] as? [String: AnyObject],
            
            let temperature = main["temp"] as? Double,
            let currentCondition = weather["main"] as? String,
            let humidity = main["humidity"] as? Int,
            let pressure = main["pressure"] as? Int,
            let windSpeed = wind["speed"] as? Double,
            let windDeg = wind["deg"] as? Int
        
        else { return nil }

        return Weather(currentCondition: currentCondition, temperature: temperature, pressure: pressure, humidity: humidity, windSpeed: windSpeed, windDeg: windDeg)
    }
}

protocol WeatherServiceDelegate {
    func weatherService(_ weatherService: WeatherService, didUpdate weather: Weather)
    func weatherService(_ weatherService: WeatherService, didFail error: Error)
}

class WeatherService {
    
    var delegate : WeatherServiceDelegate?
    
    let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    let apiKey = "15d71488fe6029f5e64f1ea5a1998876"
    
    func getWeather(for coordinate: CLLocationCoordinate2D) {
        
        let lat = String(coordinate.latitude)
        let lon = String(coordinate.longitude)
     
        let requestURL = URL(string: "\(baseURL)?lat=\(lat)&lon=\(lon)&APPID=\(apiKey)")!
        print("*** Request URL: \(requestURL)")
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                print("*** Error: \(error.localizedDescription)")
                self.delegate?.weatherService(self, didFail: error)
            } else {
                do {
                    let weatherJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                    let weather = Weather.weatherFromJSON(json: weatherJSON)
                    self.delegate?.weatherService(self, didUpdate: weather)
                }
                catch let error {
                    print("*** JSON Error: \(error.localizedDescription)")
                    self.delegate?.weatherService(self, didFail: error)
                }
            }
        }
        dataTask.resume()
    }
}
