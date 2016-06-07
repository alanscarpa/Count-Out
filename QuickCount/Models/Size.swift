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
    // TODO: Connect this random stuff to real data
    var inCount = Int(arc4random_uniform(250) + 75)
    var outCount = Int(arc4random_uniform(50) + 25)
    var amountSold: Int {
        return inCount - outCount
    }
    var grossAmount: Double {
        return Double(amountSold) * item.price
    }
    var item = Item()
    
    convenience init(name: String, weightInOunces: Double) {
        self.init()
        self.name = name
        self.weightInOunces = weightInOunces
    }
    
}