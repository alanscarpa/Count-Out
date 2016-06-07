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
    
    func configureForSize(size: Size) {
        sizeLabel.text = size.name
        priceLabel.text = "$\(size.item.price.stringWithDecimalIfNeeded())"
        inLabel.text = "\(size.inCount)"
        outLabel.text = "\(size.outCount)"
        soldLabel.text = "\(size.amountSold)"
        grossLabel.text = "$\(size.grossAmount.stringWithDecimalIfNeeded())"
    }
}
