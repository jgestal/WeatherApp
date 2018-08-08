//
//  ViewController.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 8/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        // Do any additional setup after loading the view, typically from a nib.
        
        if isLocationServicesEnabled() {
            if let coordinate = locationManager.location?.coordinate {
                print("Latitude: \(coordinate.latitude) Longitude: \(coordinate.longitude)")
                let weatherService = WeatherService()
                weatherService.getWeather(for: coordinate)
            }
        } else {
            
        }
    }
}

extension ViewController: CLLocationManagerDelegate {

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }

    func isLocationServicesEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                print("*** Location Authorized")
                return true
            default:
                print("*** Location not Authorized")
                return false
            }
        } else {
            return false
        }
    }
}
