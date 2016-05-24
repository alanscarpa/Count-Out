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
        static let kPeripheral = "peripheral"
        static let kUserBluetooth = "userBluetooth"
    }
    
    struct Code {
        static let kDiscoveredWrongPeripheral = 001
    }
    
    struct Description {
        static let kDiscoveredWrongPeripheral = "Connected to the wrong Bluetooth device.  Turn off all other nearby Bluetooth devices and try again."
        static let kBluetoothIsOffOnDevice = "Please enable Bluetooth on this phone.  This can be achieved by swiping up from the bottom of your phone and tapping the Bluetooth icon or by going to Settings."
        static let kBluetoothIsUnauthorized = "You do not have authorization to use Bluetooth on this phone.  Please get authorization to continue."
        static let kBluetoothIsUnsupported = "We're sorry - your phone does not support Bluetooth connectivity."
    }
    
}