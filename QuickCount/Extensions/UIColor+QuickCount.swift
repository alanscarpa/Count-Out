//
//  UIColor+QuickCount.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/24/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

extension UIColor {
    class func qcWhite() -> UIColor {
        return UIColor(red: 254.0/255.0, green: 254.0/255.0, blue: 254.0/255.0, alpha: 1)
    }
    
    class func qcBlack() -> UIColor {
        return UIColor(red: 28.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 1)
    }
    
    class func qcBlackTransparent() -> UIColor {
        return UIColor(red: 28.0/255.0, green: 28.0/255.0, blue: 28.0/255.0, alpha: 0.7)
    }
}