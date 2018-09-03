//
//  AnalogTermometerView.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 10/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit
@IBDesignable
class AnalogTermometerView: CustomTouchView {
    var degrees: Double?
    var isCelsiusKmhEnabled: Bool?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        StyleKit.drawTermometer(frame: bounds, resizing: .aspectFit, dayTheme: dayTheme, termometerDegrees: CGFloat(degrees ?? 0), termometerCelsius: isCelsiusKmhEnabled ?? false)
    }
    
    func update(degrees: Double, isCelsiusKmhEnabled: Bool) {
        self.degrees = degrees
        self.isCelsiusKmhEnabled = isCelsiusKmhEnabled
        setNeedsDisplay()
    }
    override func clear() {
        super.clear()
        degrees = nil
        setNeedsDisplay()
    }
}
