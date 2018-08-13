//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Juan Gestal Romani on 13/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    func test_Units_CelsiusUnits() {
        XCTAssertEqual("23".celsiusUnits(), "23 °C")
    }
    
    func test_Units_Mph() {
        XCTAssertEqual("100".mphUnits(), "100 mph")
    }
    
    func test_Units_KelvinToCelsius() {
        XCTAssertEqual(23.0.kelvinToCelsius(), -250.15, accuracy: 0.000000001)
        XCTAssertEqual(0.kelvinToCelsius(), -273.15, accuracy: 0.000000001)
        XCTAssertEqual(273.15.kelvinToCelsius(), 0, accuracy: 0.000000001)
    }
    
    func test_Units_WindDirectionForDegrees() {
        XCTAssertEqual(0.windDirection(), "East")
        XCTAssertEqual(45.windDirection(), "North East")
        XCTAssertEqual(90.windDirection(), "North")
        XCTAssertEqual(135.windDirection(), "North West")
        XCTAssertEqual(180.windDirection(), "West")
        XCTAssertEqual(225.windDirection(), "South West")
        XCTAssertEqual(270.windDirection(), "South")
        XCTAssertEqual(315.windDirection(), "South East")
    }
    
    
}




