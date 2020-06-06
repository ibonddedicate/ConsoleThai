//
//  Gradient.swift
//  ConsoleThai
//
//  Created by Surote Gaide on 6/6/20.
//  Copyright © 2020 Surote Gaide. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBG(colorOne:UIColor, colorTwo:UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

struct Colors {
    
    static let blue = UIColor(red: 0.0/255.0, green: 66.0/255.0, blue: 255.0/255.0, alpha: 1)
    static let darkblue = UIColor(red: 0.0/255.0, green: 40.0/255.0, blue: 99.0/255.0, alpha: 1)
    static let red = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
    static let darkred = UIColor(red: 99.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
    static let green = UIColor(red: 35.0/255.0, green: 164.0/255.0, blue: 57.0/255.0, alpha: 1)
    static let darkgreen = UIColor(red: 13.0/255.0, green: 111.0/255.0, blue: 30.0/255.0, alpha: 1)
}
