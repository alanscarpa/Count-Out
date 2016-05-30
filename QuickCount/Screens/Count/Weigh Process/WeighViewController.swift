//
//  WeighViewController.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/29/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit
import CoreBluetooth

protocol WeighProcessDelegate: class {
    func selectSizeNextButtonTapped(sizeIndex: Int, inOut: String)
}

class WeighViewController: UIViewController, BluetoothManagerDelegate, WeighProcessDelegate {

    @IBOutlet weak var weighProcessView: WeighProcessView!
    var item = Item()
    let selectSizeView = SelectSizeView.ip_fromNib()
    let weighView = WeighView.ip_fromNib()
    let countingView = CountingView.ip_fromNib()
    let resultsView = ResultsView.ip_fromNib()
    
    let bluetoothManager = BluetoothManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectSizeView.delegate = self
        selectSizeView.sizeSegmentedControl.removeAllSegments()
        for (index, size) in item.sizes.enumerate() {
            selectSizeView.sizeSegmentedControl.insertSegmentWithTitle(size, atIndex: index, animated: false)
        }
//        selectSizeView.sizeSegmentedControl = UISegmentedControl(items: item.sizes)
        weighProcessView.loadInitialView(selectSizeView)
        setUpBluetooth()
    }
    
    func setUpBluetooth() {
        bluetoothManager.delegate = self
        bluetoothManager.prepareToConnectToScale()
    }
    
    // MARK: WeighProcessDelegate
    
    func selectSizeNextButtonTapped(sizeIndex: Int, inOut: String) {
        // TODO: Check size and inOut before transitioning
        weighView.shirtsLabel.text = "Place \(item.sizes[sizeIndex]) \(item.name)s On Scale"
        weighProcessView.currentView = weighView
    }
    
    // MARK: BluetoothManagerDelegate
    
    func gettingWeightReading() {
        print("Connected to scale & getting weight reading!")
    }
    
    func receivedWeightReading(weight: String) {
        // TODO: Only get 1 weight reading
        print(weight)
    }
    
    func receivedBluetoothError(error: NSError) {
        if let errorMessage = error.userInfo[NSLocalizedDescriptionKey] as? String {
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.presentViewController(UIAlertController.bluetoothErrorWithMessage(errorMessage), animated: true, completion: nil)
            })
        }
    }
    
    func receivedUserBluetoothError(errorState: CBCentralManagerState) {
        // TODO: Maybe show a modal, preventing user from attempting to use scale until Bluetooth is enabled
        switch errorState {
        case .PoweredOff:
            break
        case .Unsupported:
            break
        case .Unauthorized:
            break
        default:
            break
        }
    }
    
    func userEnabledBluetooth() {
        // TODO: Dismiss modal instructing user to turn on bluetooth if it exists?
    }

}
