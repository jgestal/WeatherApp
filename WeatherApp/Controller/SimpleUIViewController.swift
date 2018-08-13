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

class SimpleUIViewController: UIViewController {

    var locationManager = CLLocationManager()
    var weather : Weather? {
        didSet {
            weatherInfoContainer.isHidden = false
            updateUI()
        }
    }
    
    var retrieveWeatherWhenLocationComesAvailable = false
    
    @IBOutlet weak var weatherInfoContainer: UIView!
    @IBOutlet weak var currentConditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearUI()
        setupLocationManager()
        updateWeather()
        weatherInfoContainer.isHidden = true
        self.title = "Weather App"
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        clearUI()
        updateWeather()
    }
    
    func updateWeather() {
        if isLocationServicesEnabled() {
            if let coordinate = locationManager.location?.coordinate {
                SVProgressHUD.show()
                statusLabel.text = ""
                let weatherService = WeatherService()
                weatherService.delegate = self
                weatherService.getWeather(for: coordinate)
                print("*** Weather Service: Update Weather")
            }
            else {
                print("*** No Location Available")
                statusLabel.text = "Waiting for user location..."
                retrieveWeatherWhenLocationComesAvailable = true
            }
        } else {
            statusLabel.text = "The app needs access to user location to work."
        }
    }
    
    func clearUI() {
        currentConditionLabel.text = ""
        temperatureLabel.text = ""
        windSpeedLabel.text = ""
        windDirectionLabel.text = ""
        statusLabel.text = ""
        weatherIcon.image = nil
    }
    
    func updateUI() {
        guard let weather = weather else { return }
        
        currentConditionLabel.text = weather.currentCondition
        temperatureLabel.text = String(weather.temperature.kelvinToCelsius()).celsiusUnits()
        windSpeedLabel.text = String(weather.windSpeed).mphUnits()
        windDirectionLabel.text = weather.windDeg.windDirection()
        weatherIcon.loadImageUsingCache(withUrl: weather.iconURLString())
        statusLabel.text = "Last update: \(weather.timestamp.dateString())"
    }
}

//MARK: Location

extension SimpleUIViewController: CLLocationManagerDelegate {

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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("*** Location Manager: Did change Authorization")
        //updateWeather()
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if retrieveWeatherWhenLocationComesAvailable {
            updateWeather()
            retrieveWeatherWhenLocationComesAvailable = false
        }
    }
}

//MARK: Weather Service

extension SimpleUIViewController: WeatherServiceDelegate {
    
    func weatherService(_ weatherService: WeatherService, didFail errorDesc: String) {
        SVProgressHUD.showError(withStatus: errorDesc)
        if let oldWeather = Weather.lastWeatherUpdate() {
            weather = oldWeather
        } else {
            statusLabel.text = "No weather data"
        }
    }
    
    func weatherService(_ weatherService: WeatherService, didUpdate weather: Weather) {
        SVProgressHUD.dismiss()
        self.weather = weather
    }
}
