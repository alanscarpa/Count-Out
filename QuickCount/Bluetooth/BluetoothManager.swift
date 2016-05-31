//
//  BluetoothManager.swift
//  Counted
//
//  Created by Alan Scarpa on 5/23/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import Foundation
import CoreBluetooth
import Intrepid

protocol BluetoothManagerDelegate: class {
    func receivedWeightReadingInOunces(weight: Double)
    func receivedBluetoothError(error: NSError)
    func userEnabledBluetooth()
    func receivedUserBluetoothError(errorState: CBCentralManagerState)
    func gettingWeightReading()
}

class BluetoothManager: NSObject, BTDiscoveryDelegate {
    static let sharedInstance = BluetoothManager()
    let btDiscoveryManager = BTDiscovery()
    weak var delegate: BluetoothManagerDelegate?
    
    override init() {
        super.init()
        btDiscoveryManager.delegate = self
        registerNotifications()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func prepareToConnectToScale() {
        btDiscoveryManager.prepareToConnectToScale()
    }
    
    func disconnectFromScale() {
        btDiscoveryManager.disconnect()
    }
    
    // MARK: Notifications
    
    func registerNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didReceiveWeightReading(_:)), name: kDidGetWeightReading, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didReceiveBluetoothError(_:)), name: kBluetoothError, object: nil)
    }
    
    func didReceiveWeightReading(notification: NSNotification) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            if let weight = notification.userInfo?["weight"] as? Double {
                self.delegate?.receivedWeightReadingInOunces(weight * 16)
            }
        }
    }
    
    func didReceiveBluetoothError(notification: NSNotification) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            if let error = notification.userInfo?[kBluetoothError] as? NSError {
                self.delegate?.receivedBluetoothError(error)
            }
        }
    }
    
    // MARK: BluetoothDiscoveryDelegate
    
    func didConnectToScale() {
        Main {
            self.delegate?.gettingWeightReading()
        }
    }
    
    func userEnabledBluetooth() {
        Main {
            self.delegate?.userEnabledBluetooth()
        }
    }
    
    func userBluetoothError(errorState: CBCentralManagerState) {
        Main {
            self.delegate?.receivedUserBluetoothError(errorState)
        }
    }

}