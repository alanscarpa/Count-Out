//
//  ResultsView.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/29/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class ResultsView: UIView {
    
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
        
    func configureForWeight(weight: Double, item: Item, andSize size: Size) {
        countLabel.text = "\(Int(weight / size.weightInOunces))"
        nameLabel.text = "\(size.name) \(item.name)s"
    }
    
}
