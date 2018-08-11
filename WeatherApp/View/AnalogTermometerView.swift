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

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        StyleKit.drawTermometer(frame: bounds, resizing: .aspectFit, termometerDegrees: CGFloat(degrees ?? 0), dayTheme:dayTheme)
    }
    func update(degrees: Double) {
        self.degrees = degrees
        setNeedsDisplay()
    }
    override func clear() {
        super.clear()
        degrees = nil
        setNeedsDisplay()
    }
}
