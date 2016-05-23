//
//  Errors.swift
//  Counted
//
//  Created by Alan Scarpa on 5/23/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import Foundation

struct Errors {
    
    struct Domain {
        static let kPeripheral = "peripheralDomain"
    }
    
    struct Code {
        static let kDiscoveredWrongPeripheral = 001
    }
    
    struct Description {
        static let kDiscoveredWrongPeripheral = "Connected to the wrong Bluetooth device.  Turn off all other nearby Bluetooth devices and try again."
    }
    
}