//
//  AnalogHumidityDisplayView.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 10/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit
@IBDesignable
class AnalogHumidityDisplayView: CustomTouchView {
    var humidity: Double?
    override func draw(_ rect: CGRect) {
        StyleKit.drawHumidityDisplay(frame: bounds, resizing: .aspectFit, humidity: CGFloat(humidity ?? 0), dayTheme: dayTheme)
    }
    func update(humidity: Double) {
        self.humidity = humidity
        setNeedsDisplay()
    }
    override func clear() {
        super.clear()
        humidity = nil
        setNeedsDisplay()
    }
}
