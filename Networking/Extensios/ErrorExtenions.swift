//
//  ErrorExtenions.swift
//  Networking
//
//  Created by karim  on 08/08/2022.
//

import Foundation
import UIKit

extension NSError {
    class func create(description: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: description])
    }
}

extension UIView {
    func shake(duration timeDuration: Double = 0.07, repeat countRepeat: Float = 3){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = timeDuration
        animation.repeatCount = countRepeat
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
