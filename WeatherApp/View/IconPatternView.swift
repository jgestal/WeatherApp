//
//  BackgroundPatternView.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 11/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit
class IconPatternView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "icon_pattern"))
    }
}
