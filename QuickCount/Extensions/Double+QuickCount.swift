//
//  Double+QuickCount.swift
//  QuickCount
//
//  Created by Alan Scarpa on 6/6/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import Foundation

extension Double {
    func stringWithDecimalIfNeeded() -> String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        return numberFormatter.stringFromNumber(NSNumber(double: self)) ?? ""
    }
}