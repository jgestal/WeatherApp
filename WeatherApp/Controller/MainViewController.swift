//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 10/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import Foundation


import UIKit
import CoreLocation
import SVProgressHUD

class MainViewController: UIViewController {
    var dayTheme: Bool = true {
        didSet {
            updateUI()
        }
    }
    
    var locationManager = CLLocationManager()
    var weather : Weather? {
        didSet {
            //weatherInfoContainer.isHidden = false
            updateUI()
        }
    }
    
    var retrieveWeatherWhenLocationComesAvailable = false
    
    @IBOutlet weak var deviceFrameView: DeviceFrameView!
    
    @IBOutlet weak var humidityDisplay: AnalogHumidityDisplayView!
    @IBOutlet weak var termometer: AnalogTermometerView!
    @IBOutlet weak var windCompassDisplay: AnalogCompassDisplayView!
    
    @IBOutlet weak var refreshButtonView: CustomButtonView!
    @IBOutlet weak var nightModeButtonView: CustomButtonView!
    @IBOutlet weak var creditsButtonView: CustomButtonView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBOutlet weak var frontView: WoodView!
    @IBOutlet weak var backView: WoodView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearUI()
        setupLocationManager()
        updateWeather()
     //   weatherInfoContainer.isHidden = true
        self.title = "Weather App"
        
        humidityDisplay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(humidityDisplayTapped)))
        termometer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termometerTapped)))
        windCompassDisplay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(windCompassDisplayTapped)))
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backViewTapped)))
        
        [refreshButtonView,nightModeButtonView,creditsButtonView].forEach {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customButtonTapped)))
        }
    }
    
    
    func updateWeather() {
        if isLocationServicesEnabled() {
            if let coordinate = locationManager.location?.coordinate {
                SVProgressHUD.show()
                //statusLabel.text = ""
                let weatherService = WeatherService()
                weatherService.delegate = self
                weatherService.getWeather(for: coordinate)
                print("*** Weather Service: Update Weather")
            }
            else {
                print("*** No Location Available")
                //statusLabel.text = "Waiting for user location..."
                retrieveWeatherWhenLocationComesAvailable = true
            }
        } else {
            statusLabel.text = "The app needs access to user location to work."
        }
    }
    
    func clearUI() {
        [windCompassDisplay,termometer,humidityDisplay].forEach {
            $0.clear()
        }
        
        //currentConditionLabel.text = ""
        //temperatureLabel.text = ""
        //windSpeedLabel.text = ""
        //windDirectionLabel.text = ""
        //statusLabel.text = ""
        //weatherIcon.image = nil
    }
    
    func updateUI() {
        guard let weather = weather else { return }
        print("*** Update UI")

        let theme = dayTheme
        [windCompassDisplay,termometer,humidityDisplay,refreshButtonView,nightModeButtonView,creditsButtonView].forEach { $0.dayTheme = theme }
        titleLabel.textColor = theme ? StyleKit.flatBlackLight : StyleKit.flatWhiteLight
        deviceFrameView.dayTheme = theme
        windCompassDisplay.update(angle: Double(weather.windDeg), velocityText: String(weather.windSpeed).mphUnits())
        termometer.update(degrees: weather.temperature.kelvinToCelsius())
        humidityDisplay.update(humidity: Double(weather.humidity) / 100)
        
        //statusLabel.text = "Last update: \(weather.dateString())"
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
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

extension MainViewController: WeatherServiceDelegate {
    
    func weatherService(_ weatherService: WeatherService, didFail errorDesc: String) {
        SVProgressHUD.showError(withStatus: errorDesc)
        if let oldWeather = Weather.lastWeatherUpdate() {
            weather = oldWeather
        } else {
            print("*** No old weather data")
//            statusLabel.text = "No weather data"
        }
    }
    
    func weatherService(_ weatherService: WeatherService, didUpdate weather: Weather) {
        SVProgressHUD.dismiss()
        self.weather = weather
    }
}


extension MainViewController {
    
    @objc func humidityDisplayTapped() {
        print("Humidity Display Tapped")
        if let weather = weather {
            let text = "Humidity is \(weather.humidity) percent."
            SoundManager.shared.readText(text: text)
        }
    }
    
    @objc func termometerTapped() {
        print("Termometer Tapped")
        if let weather = weather {
            let temperatureRounded = String(format: "%.1f", weather.temperature.kelvinToCelsius())
            let text = "The temperature is \(temperatureRounded) degrees"
            SoundManager.shared.readText(text: text)
        }
    }
    
    @objc func windCompassDisplayTapped() {
        print("Wind Compass Display Tapped")
        if let weather = weather {
            let text = "The wind direction is \(weather.windDirection()) and its speed is \(weather.windSpeed) miles per hour."
            SoundManager.shared.readText(text: text)
        }
    }
    
    @objc func customButtonTapped(sender: UITapGestureRecognizer) {
        switch sender.view?.tag {
        case 0:
            print("*** Refresh Button Tapped")
            updateWeather()
        case 1:
            print("*** Change theme")
            dayTheme = !dayTheme            
        case 2:
            print("*** Credits Button Tapped")
            updateUI()
            flip(firstView: frontView, secondView: backView)
        default:
            break
        }
    }
    
    @objc func backViewTapped() {
        flip(firstView: backView, secondView: frontView)
    }
}

extension MainViewController {
    @objc func flip(firstView: UIView, secondView: UIView) {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
        UIView.transition(with: firstView, duration: 1.0, options: transitionOptions, animations: {
            firstView.isHidden = true
        })
        UIView.transition(with: secondView, duration: 1.0, options: transitionOptions, animations: {
            secondView.isHidden = false
        })
    }
}

