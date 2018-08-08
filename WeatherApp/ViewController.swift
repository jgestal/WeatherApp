//
//  ViewController.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 8/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class ViewController: UIViewController {

    var locationManager = CLLocationManager()
    var weather : Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        updateWeather()
    }
    
    func updateWeather() {
        if isLocationServicesEnabled() {
            if let coordinate = locationManager.location?.coordinate {
                SVProgressHUD.show()
                let weatherService = WeatherService()
                weatherService.delegate = self
                weatherService.getWeather(for: coordinate)
            }
        } else {
            
        }
    }
    
    func updateUI() {
        guard let weather = weather else { return }
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

extension ViewController: WeatherServiceDelegate {
    
    func weatherService(_ weatherService: WeatherService, didFail errorDesc: String) {
        SVProgressHUD.showError(withStatus: errorDesc)
    }
    
    func weatherService(_ weatherService: WeatherService, didUpdate weather: Weather) {
        SVProgressHUD.dismiss()
        self.weather = weather
        updateUI()
    }
}
