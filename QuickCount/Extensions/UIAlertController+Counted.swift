//
//  UIAlertController+Counted.swift
//  Counted
//
//  Created by Alan Scarpa on 5/23/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func bluetoothErrorWithMessage(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Bluetooth Error", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(action)
        return alert
    }
}