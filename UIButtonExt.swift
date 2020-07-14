//
//  UIButtonExt.swift
//  Pig
//
//  Created by Ted Nesham on 7/10/20.
//  Copyright © 2020 UMSL. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 0.8
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.9
        pulse.damping = 0.1
        
        layer.add(pulse, forKey: nil)
    }
}
