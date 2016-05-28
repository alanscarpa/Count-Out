//
//  HomeTableViewCell.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/28/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet private weak var dateLabel: QCLabel!
    @IBOutlet private weak var artistLabel: QCLabel!
    @IBOutlet private weak var venueLabel: QCLabel!
    @IBOutlet private weak var venueImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // TODO: Demo purposes only.  Delete once we have data source.
    func configureForBarclays() {
        headerLabel.text = "TOMORROW'S SHOW"
        dateLabel.text = "06/02/2016"
        artistLabel.text = "CRIMSON RAT TAIL"
        venueLabel.text = "BARCLAYS CENTER"
        venueImageView.image = UIImage(named: "barclaysCenter")
    }
    
}
