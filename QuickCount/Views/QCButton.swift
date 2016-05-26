//
//  QCButton.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/24/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class QCButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUp()
    }
    
    func setUp() {
        self.layer.borderColor = UIColor.qcWhite().CGColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 6
        self.titleLabel?.font = UIFont.qcDosisBold(15)
        self.setTitleColor(UIColor.qcWhite(), forState: .Normal)
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 0.5
    }
    
    func setBorderColor(color: CGColor) {
        self.layer.borderColor = color
    }

}
