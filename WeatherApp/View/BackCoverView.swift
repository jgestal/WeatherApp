//
//  BackCoverView.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 11/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit
@IBDesignable
class BackCoverView: UIView {
    override func draw(_ rect: CGRect) {
        StyleKit.drawBackCover(frame: bounds, resizing: .aspectFit)
    }
}
