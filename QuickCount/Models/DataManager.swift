//
//  DataManager.swift
//  QuickCount
//
//  Created by Alan Scarpa on 6/6/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    static let sharedInstance: DataManager = {
        let shared = DataManager()
        return shared
    }()
    
    var items: [Item] = {
        let small = Size(name: "S", weightInOunces: 16)
        let medium = Size(name: "M", weightInOunces: 6.7)
        let large = Size(name: "L", weightInOunces: 7.7)
        let extraLarge = Size(name: "XL", weightInOunces: 9.7)
        let items = [
            Item(name: "Black FOB Skull Shirt", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage1")),
            Item(name: "Red Crossbones Hoodie", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage3")),
            Item(name: "Ladies Blue Tank Top", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage4")),
            Item(name: "Tour Tee", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage6")),
            Item(name: "High Flying Eagle Shirt", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage2")),
            Item(name: "American Flag Hoodie", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage5"))
        ]
        return items
    }()
    
    private init(){}
    
}