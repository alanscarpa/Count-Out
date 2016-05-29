//
//  CountTableViewCell.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/29/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class CountTableViewCell: UITableViewCell {

    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabelLeadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureForItem(item: Item) {
        itemNameLabel.text = item.name
        if let image = item.image {
            itemImageView.image = image
        } else {
            itemImageWidthConstraint.constant = 0
            titleLabelLeadingConstraint.constant = 0
        }
    }
    
}
