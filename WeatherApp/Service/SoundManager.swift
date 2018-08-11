//
//  SoundManager.swift
//  WeatherApp
//
//  Created by Juan Gestal Romani on 10/8/18.
//  Copyright © 2018 Juan Gestal Romani. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    private init() { }
    static let shared = SoundManager()
    
    var syntesizer : AVSpeechSynthesizer?
    
    func readText(text: String) {
        syntesizer?.stopSpeaking(at: .immediate)
        syntesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: text)
        syntesizer?.speak(utterance)
    }
}
