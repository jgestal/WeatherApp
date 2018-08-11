//
//  CustomButtonView.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 11/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit

@IBDesignable

class CustomButtonView: CustomTouchView {
    
    override var dayTheme: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        switch tag {
        case 0:
            StyleKit.drawRefreshButton(frame: bounds, resizing: .aspectFill, dayTheme: dayTheme)
        case 1:
            StyleKit.drawNightModeButton(frame: bounds, resizing: .aspectFill, dayTheme: dayTheme)
        case 2:
            StyleKit.drawCreditsButton(frame: bounds, resizing: .aspectFill, dayTheme: dayTheme)
        default:
            break
        }
    }
}
