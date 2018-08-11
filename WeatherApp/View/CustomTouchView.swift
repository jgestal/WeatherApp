//
//  PCView.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 11/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit

class CustomTouchView: UIView {
    var dayTheme: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    func clear() {
        dayTheme = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dayTheme = !dayTheme
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dayTheme = !dayTheme
    }
}
