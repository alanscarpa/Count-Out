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
    
    // MARK: Private
    
    private func startDiscoveringServices() {
        peripheral?.discoverServices(nil)
    }
    
    private func reset() {
        if peripheral != nil {
            peripheral = nil
        }
    }
    
    // MARK: CBPeripheralDelegate
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        if peripheral != peripheral || error != nil {
            print("Problem discovering services")
            if let error = error {
                print(error)
            }
            return
        }
        guard let services = peripheral.services where peripheral.services?.count > 0 else { return }

        for service in services {
            let thisService = service as CBService
            if thisService.UUID == weightServiceCBUUID {
                peripheral.discoverCharacteristics(nil, forService: thisService)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if peripheral != peripheral || error != nil {
            print("Problem discovering services")
            if let error = error {
                print(error)
            }
            return
        }
        
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic)
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
        
        // 206 means scale has final weight
        if array[0] == 206 {
            let weightInPounds = Double(CFSwapInt32BigToHost(array[1])) * 0.00000336223
            print(weightInPounds)
        }
       
    }
    
}
