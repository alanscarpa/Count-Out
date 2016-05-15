//
//  Service.swift
//  Counted
//
//  Created by Alan Scarpa on 5/15/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import Foundation
import CoreBluetooth

/* Services & Characteristics UUIDs */
let BLEServiceUUID = CBUUID(string: "025A7775-49AA-42BD-BBDB-E2AE77782966")
let PositionCharUUID = CBUUID(string: "F38A2C23-BC54-40FC-BED0-60EDDA139F47")
let BLEServiceChangedStatusNotification = "kBLEServiceChangedStatusNotification"

class BTService: NSObject, CBPeripheralDelegate {
    var peripheral: CBPeripheral?
    var positionCharacteristic: CBCharacteristic?
    
    init(initWithPeripheral peripheral: CBPeripheral) {
        super.init()
        self.peripheral = peripheral
        self.peripheral?.delegate = self
        startDiscoveringServices()
    }
    
    deinit {
        reset()
    }
    
    func startDiscoveringServices() {
        peripheral?.discoverServices(nil)
    }
    
    func reset() {
        if peripheral != nil {
            peripheral = nil
        }
        
        // Deallocating therefore send notification
        sendBTServiceNotificationWithIsBluetoothConnected(false)
    }
    
    // Mark: - CBPeripheralDelegate
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        let uuidsForBTService: [CBUUID] = [PositionCharUUID]
        
        if (peripheral != peripheral) {
            // Wrong Peripheral
            return
        }
        
        if (error != nil) {
            return
        }
        
        if ((peripheral.services == nil) || (peripheral.services!.count == 0)) {
            // No Services
            return
        }
        guard let services = peripheral.services else { return }
        
//        for service in peripheral.services! {
//            if service.UUID == BLEServiceUUID {
//                peripheral.discoverCharacteristics(uuidsForBTService, forService: service)
//            }
//        }
        print("Looking at peripheral services")
        for service in services {
            let thisService = service as CBService
//            if service.UUID == IRTemperatureServiceUUID {
//                // Discover characteristics of IR Temperature Service
//                peripheral.discoverCharacteristics(nil, forService: thisService)
//            }
            print(thisService.UUID)
            peripheral.discoverCharacteristics(nil, forService: thisService)
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if (peripheral != peripheral) {
            // Wrong Peripheral
            return
        }
        
        if (error != nil) {
            return
        }
        
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                    positionCharacteristic = (characteristic)
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic)
//                    print(peripheral.readValueForCharacteristic(characteristic))
                    // Send notification that Bluetooth is connected and all required characteristics are discovered
                    sendBTServiceNotificationWithIsBluetoothConnected(true)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        guard let data = characteristic.value else { return }

        // the number of elements:
        let count = data.length / sizeof(UInt32)
        
        // create array of appropriate length:
        var array = [UInt32](count: count, repeatedValue: 0)
        
        // copy bytes into array
        data.getBytes(&array, length:count * sizeof(UInt32))
//        print(array)
        
        // 206 means scale has final weight
        if array[0] == 206 {
            let weightInPounds = Double(CFSwapInt32BigToHost(array[1])) * 0.00000336223
            print(weightInPounds)
        }
       
    }
    
    // Mark: - Private
    
    func writePosition(position: UInt8) {
        
        /******** (1) CODE TO BE ADDED *******/
        
    }
    
    func sendBTServiceNotificationWithIsBluetoothConnected(isBluetoothConnected: Bool) {
        let connectionDetails = ["isConnected": isBluetoothConnected]
        NSNotificationCenter.defaultCenter().postNotificationName(BLEServiceChangedStatusNotification, object: self, userInfo: connectionDetails)
    }
    
}
