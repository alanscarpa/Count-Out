//
//  SelectSizeView.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/29/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class SelectSizeView: WeighProcessView {
    
    @IBOutlet weak var sizeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var inOutSegmentedControl: UISegmentedControl!
    weak var delegate: WeighProcessDelegate?
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        var inOut = ""
        if inOutSegmentedControl.selectedSegmentIndex == 0 {
            inOut = "In"
        } else {
            inOut = "Out"
        }
        delegate?.selectSizeNextButtonTapped(sizeSegmentedControl.selectedSegmentIndex, inOut: inOut)
    }
}