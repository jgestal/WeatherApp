//
//  WoodImageView.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 10/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import UIKit

class WoodView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "wood_pattern"))
    }
}
