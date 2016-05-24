//
//  Service.swift
//  Counted
//
//  Created by Alan Scarpa on 5/15/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import Foundation
import CoreBluetooth

class BTService: NSObject, CBPeripheralDelegate {
    var peripheral: CBPeripheral?
    let weightServiceCBUUID = CBUUID(string: "FFF0")
    
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
    
    // MARK: CBPeripheralDelegate
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if let error = errorForPeripheral(peripheral, error: error) {
            NSNotificationCenter.defaultCenter().postNotificationName(kBluetoothError, object: self, userInfo: [kBluetoothError: error])
            print(error)
        } else {
            guard let services = peripheral.services where peripheral.services?.count > 0 else { return }
            for service in services {
                let thisService = service as CBService
                if thisService.UUID == weightServiceCBUUID {
                    peripheral.discoverCharacteristics(nil, forService: thisService)
                }
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if let error = errorForPeripheral(peripheral, error: error) {
            NSNotificationCenter.defaultCenter().postNotificationName(kBluetoothError, object: self, userInfo: [kBluetoothError: error])
            print(error)
        } else {
            if let characteristics = service.characteristics {
                for characteristic in characteristics {
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic)
                }
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        guard let data = characteristic.value else {
            if let error = errorForPeripheral(peripheral, error: error) {
                NSNotificationCenter.defaultCenter().postNotificationName(kBluetoothError, object: self, userInfo: [kBluetoothError: error])
                print(error)
            }
            return
        }

        // the number of elements:
        let count = data.length / sizeof(UInt32)
        
        // create array of appropriate length:
        var array = [UInt32](count: count, repeatedValue: 0)
        
        // copy bytes into array
        data.getBytes(&array, length:count * sizeof(UInt32))
        
        // 206 means scale has final weight
        if array[0] == 206 {
            let weightInPounds = Double(CFSwapInt32BigToHost(array[1])) * 0.00000336223
            NSNotificationCenter.defaultCenter().postNotificationName(kDidGetWeightReading, object: nil, userInfo: ["weight": weightInPounds])
        }
    }
    
    // MARK: Helpers
    
    private func reset() {
        if peripheral != nil {
            peripheral = nil
        }
    }
    
    private func errorForPeripheral(peripheral: CBPeripheral, error: NSError?) -> NSError? {
        if peripheral != peripheral {
            return NSError(domain: Errors.Domain.kPeripheral, code: Errors.Code.kDiscoveredWrongPeripheral, userInfo: [NSLocalizedDescriptionKey: Errors.Description.kDiscoveredWrongPeripheral])
        } else if let error = error {
            return error
        } else {
            return nil
        }
    }
    
}
