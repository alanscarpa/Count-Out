//
//  Discovery.swift
//  Counted
//
//  Created by Alan Scarpa on 5/15/16.
//  Copyright © 2016 Counted. All rights reserved.
//


import Foundation
import CoreBluetooth

protocol BTDiscoveryDelegate: class {
    func userEnabledBluetooth()
    func userBluetoothError(errorState: CBCentralManagerState)
    func didConnectToScale()
}

class BTDiscovery: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    static let sharedManager = BTDiscovery()
    private var centralManager: CBCentralManager?
    private var peripheralBLE: CBPeripheral?
    private let bluetoothScaleName = "ElecScalesBH"
    var bleService: BTService? {
        didSet {
            if let service = bleService {
                service.startDiscoveringServices()
            }
        }
    }
    weak var delegate: BTDiscoveryDelegate?
    
    func disconnect() {
        if let peripheral = peripheralBLE {
            centralManager?.cancelPeripheralConnection(peripheral)
            clearDevices()
        }
    }
    
    func prepareToConnectToScale() {
        let centralQueue = dispatch_queue_create("com.counted", DISPATCH_QUEUE_SERIAL)
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }
    
    // MARK: - CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case .PoweredOff:
            delegate?.userBluetoothError(.PoweredOff)
            clearDevices()
            
        case .Unauthorized:
            delegate?.userBluetoothError(.Unauthorized)
            break
            
        case .Unknown:
            // Wait for another event
            break
            
        case .PoweredOn:
            delegate?.userEnabledBluetooth()
            startScanning()
            
        case .Resetting:
            clearDevices()
            
        case .Unsupported:
            delegate?.userBluetoothError(.Unsupported)
            break
        }
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        // Be sure to retain the peripheral or it will fail during connection.
        if peripheral.name == bluetoothScaleName {
            peripheralBLE = peripheral
            bleService = nil
            central.connectPeripheral(peripheral, options: nil)
        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        if peripheral == peripheralBLE {
            delegate?.didConnectToScale()
            bleService = BTService(initWithPeripheral: peripheral)
        }
        central.stopScan()
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        // Error code 6 is "Connection timed out unexpectedly".  This happens whenever the scale is turned off.  We don't want to trigger error here.
        // TODO: Check if new scale behaves the same way
        if let error = error where peripheral == peripheralBLE && error.code != 6 {
            NSNotificationCenter.defaultCenter().postNotificationName(kBluetoothError, object: self, userInfo: [kBluetoothError: error])
        } else if peripheral == peripheralBLE {
            central.cancelPeripheralConnection(peripheral)
            // TODO:  If you disconnect before getting a reading, send an error.
        }
        clearDevices()
        startScanning()
    }
    
    // MARK: Private
    
    private func startScanning() {
        if let central = centralManager {
            central.scanForPeripheralsWithServices(nil, options: nil)
        }
    }
    
    private func clearDevices() {
        bleService = nil
        peripheralBLE = nil
    }
    
}
