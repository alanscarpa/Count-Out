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
        delegate?.selectSizeNextButtonTapped(sizeSegmentedControl.selectedSegmentIndex, inOut: inOutSegmentedControl.selectedSegmentIndex)
    }
    
    func configureForItem(item: Item) {
        sizeSegmentedControl.removeAllSegments()
        for (index, size) in item.sizes.enumerate() {
            sizeSegmentedControl.insertSegmentWithTitle(size.name, atIndex: index, animated: false)
        }
    }
}