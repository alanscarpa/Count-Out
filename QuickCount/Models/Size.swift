//
//  Size.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/30/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import Foundation

class Size {
    var name = ""
    var weightInOunces: Double = 0.0
    
    convenience init(name: String, weightInOunces: Double) {
        self.init()
        self.name = name
        self.weightInOunces = weightInOunces
    }
    
}