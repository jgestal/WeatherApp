//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 8/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherService {
    
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
            } else {
                do {
                    let weather = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                    print(weather)
                }
                catch let error {
                    print("*** JSON Error: \(error.localizedDescription)")
                }
            }
        }
        dataTask.resume()
    }
}
