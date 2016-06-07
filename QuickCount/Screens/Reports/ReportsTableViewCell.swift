//
//  ReportsTableViewCell.swift
//  QuickCount
//
//  Created by Alan Scarpa on 6/5/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class ReportsTableViewCell: UITableViewCell {

    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var inLabel: UILabel!
    @IBOutlet weak var outLabel: UILabel!
    @IBOutlet weak var soldLabel: UILabel!
    @IBOutlet weak var grossLabel: UILabel!
    
    func configureForSize(size: Size, ofItem item: Item) {
        sizeLabel.text = size.name
        priceLabel.text = "$\(item.price)"
        inLabel.text = "\(size.inCount)"
        outLabel.text = "\(size.outCount)"
        // TODO: Set sold/gross somewhere
        let randomSold = Int(arc4random_uniform(250) + 75)
        soldLabel.text = "\(randomSold)"
        let gross = randomSold * item.price
        grossLabel.text = "$\(gross)"
    }
}
