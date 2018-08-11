//
//  AnalogCompassDisplayView.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 10/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit
@IBDesignable
class AnalogCompassDisplayView: CustomTouchView {
    var angle: Double?
    var velocityText: String?
    override func draw(_ rect: CGRect) {
        StyleKit.drawCompassDisplay(frame: bounds, resizing: .aspectFit, compassAngle: CGFloat(angle ?? 0), compassVelocityText: velocityText ?? "0 mph", dayTheme: dayTheme)
    }
    func update(angle: Double, velocityText: String) {
        self.angle = angle
        self.velocityText = velocityText
        setNeedsDisplay()
    }
    override func clear() {
        super.clear()
        angle = nil
        velocityText = nil
        setNeedsDisplay()
    }
}
