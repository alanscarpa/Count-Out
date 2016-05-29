//
//  Item.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/29/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import Foundation

class Item {
    
    var name = ""
    var sizes = [String]()
    
    convenience init(name: String, sizes: [String]) {
        self.init()
        self.name = name
        self.sizes = sizes
    }
}