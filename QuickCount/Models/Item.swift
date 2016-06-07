//
//  Item.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/29/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import Foundation
import UIKit

class Item {
    
    var name = ""
    var sizes = [Size]() {
        didSet {
            for size in self.sizes {
                size.item = self
            }
        }
    }
    var image: UIImage?
    // TODO: Connect price to real data
    var price = Double(arc4random_uniform(25) + 10)
    var grossAmountSold: String {
        var amount: Double = 0
        for size in sizes {
            amount += size.grossAmount
        }
        return amount.stringWithDecimalIfNeeded()
    }
    convenience init(name: String, sizes: [Size], image: UIImage?) {
        self.init()
        self.name = name
        self.sizes = sizes
        self.image = image
    }
}