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
    var bleService: BTService? {
        didSet {
            if let service = bleService {
                service.startDiscoveringServices()
            }
        }
    }
    
    override init() {
        super.init()
        let centralQueue = dispatch_queue_create("com.counted", DISPATCH_QUEUE_SERIAL)
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }
    
    // MARK: - CBCentralManagerDelegate
    
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
            bleService = BTService(initWithPeripheral: peripheral)
        }
        central.stopScan()
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        if (peripheral == peripheralBLE) {
            central.cancelPeripheralConnection(peripheral)
            clearDevices()
            startScanning()
        }
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
