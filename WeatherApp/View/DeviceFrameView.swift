//
//  DeviceFrameView.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 10/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit

@IBDesignable

class DeviceFrameView: UIView {
    var dayTheme = true {
        didSet {
            setNeedsDisplay()
        }
    }
    override func draw(_ rect: CGRect) {
        StyleKit.drawDeviceFrame(frame: bounds, dayTheme: dayTheme)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
}
