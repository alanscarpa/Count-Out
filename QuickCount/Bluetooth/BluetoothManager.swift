//
//  BluetoothManager.swift
//  Counted
//
//  Created by Alan Scarpa on 5/23/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BluetoothManagerDelegate: class {
    func receivedWeightReading(weight: String)
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
    
    func connectToScale() {
        btDiscoveryManager.connectToScale()
    }
    
    // MARK: Notifications
    
    func registerNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didReceiveWeightReading(_:)), name: kDidGetWeightReading, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didReceiveBluetoothError(_:)), name: kBluetoothError, object: nil)
    }
    
    func didReceiveWeightReading(notification: NSNotification) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            if let weight = notification.userInfo?["weight"] as? Double {
                self.delegate?.receivedWeightReading(String(format:"%.2f", weight))
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
        delegate?.gettingWeightReading()
    }
    
    func userEnabledBluetooth() {
        delegate?.userEnabledBluetooth()
    }
    
    func userBluetoothError(errorState: CBCentralManagerState) {
        delegate?.receivedUserBluetoothError(errorState)
    }

}