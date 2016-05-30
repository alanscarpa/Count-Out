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
    var sizes = [Size]()
    var image: UIImage?
    
    convenience init(name: String, sizes: [Size], image: UIImage?) {
        self.init()
        self.name = name
        self.sizes = sizes
        self.image = image
    }
}