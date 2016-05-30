//
//  QCNextButton.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/30/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class QCNextButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUp()
    }
    
    func setUp() {
        self.layer.cornerRadius = 6
        self.titleLabel?.font = UIFont.qcDosisBold(24)
        self.setTitleColor(UIColor.qcGreen(), forState: .Normal)
        self.backgroundColor = UIColor.qcBlack()
    }
    
    func setBorderColor(color: CGColor) {
        self.layer.borderColor = color
    }
    
}
