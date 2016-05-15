//
//  Discovery.swift
//  Counted
//
//  Created by Alan Scarpa on 5/15/16.
//  Copyright © 2016 Counted. All rights reserved.
//


import Foundation
import CoreBluetooth


class BTDiscovery: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    static let sharedManager = BTDiscovery()
    private var centralManager: CBCentralManager?
    private var peripheralBLE: CBPeripheral?
    private let bluetoothScaleName = "ElecScalesBH"
    override init() {
        super.init()
        let centralQueue = dispatch_queue_create("com.counted", DISPATCH_QUEUE_SERIAL)
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }
    
    func startScanning() {
        if let central = centralManager {
            central.scanForPeripheralsWithServices(nil, options: nil)
        }
    }
    
    var bleService: BTService? {
        didSet {
            if let service = bleService {
                service.startDiscoveringServices()
            }
        }
    }
    
    // MARK: - CBCentralManagerDelegate
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        // Be sure to retain the peripheral or it will fail during connection.
      
        // Validate peripheral information
        if ((peripheral.name == nil) || (peripheral.name == "")) {
            return
        }
        
        // If not already connected to a peripheral, then connect to this one
        if (peripheralBLE == nil || peripheralBLE?.state == CBPeripheralState.Disconnected) && peripheral.name == bluetoothScaleName {
            
            // Retain the peripheral before trying to connect
            peripheralBLE = peripheral
            // Reset service
            bleService = nil
            
            // Connect to peripheral
            central.connectPeripheral(peripheral, options: nil)
        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        
        // Create new service class
        if (peripheral == peripheralBLE) {
            bleService = BTService(initWithPeripheral: peripheral)
        }
        
        
        
        // Stop scanning for new devices
        central.stopScan()
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        
        // See if it was our peripheral that disconnected
        if (peripheral == peripheralBLE) {
            bleService = nil;
            peripheralBLE = nil;
        }
        
        // Start scanning for new devices
        startScanning()
    }
    
    // MARK: - Private
    
    func clearDevices() {
        bleService = nil
        peripheralBLE = nil
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch (central.state) {
        case CBCentralManagerState.PoweredOff:
            // TODO: Show modal explaining how to turn on Bluetooth
            clearDevices()
            
        case CBCentralManagerState.Unauthorized:
            // Indicate to user that the iOS device does not support BLE.
            break
            
        case CBCentralManagerState.Unknown:
            // Wait for another event
            break
            
        case CBCentralManagerState.PoweredOn:
            startScanning()
            
        case CBCentralManagerState.Resetting:
            clearDevices()
            
        case CBCentralManagerState.Unsupported:
            break
        }
    }
    
}
