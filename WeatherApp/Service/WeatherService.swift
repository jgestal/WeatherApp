//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 8/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherServiceDelegate {
    func weatherService(_ weatherService: WeatherService, didUpdate weather: Weather)
    func weatherService(_ weatherService: WeatherService, didFail errorDesc: String)
}

class WeatherService {
    
    var delegate : WeatherServiceDelegate?
    
    static let kBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    static let kApiKey = "15d71488fe6029f5e64f1ea5a1998876"
    
    func getWeather(for coordinate: CLLocationCoordinate2D) {
        
        let lat = String(coordinate.latitude)
        let lon = String(coordinate.longitude)
     
        let requestURL = URL(string: "\(WeatherService.kBaseURL)?lat=\(lat)&lon=\(lon)&APPID=\(WeatherService.kApiKey)")!
        
        print("*** Request URL: \(requestURL)")
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                print("*** Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.delegate?.weatherService(self, didFail: error.localizedDescription)
                }
            } else {
                do {
                    let weatherJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                    if let weather = Weather.weatherFromJSON(json: weatherJSON) {
                        DispatchQueue.main.async {
                            self.delegate?.weatherService(self, didUpdate: weather)
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            self.delegate?.weatherService(self, didFail: "Unexpected response from server.")
                        }
                    }
                }
                catch let error {
                    print("*** JSON Error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.delegate?.weatherService(self, didFail: error.localizedDescription)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
