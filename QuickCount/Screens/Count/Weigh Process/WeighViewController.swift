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
    func selectSizeNextButtonTapped(sizeIndex: Int, inOut: Int)
    func weighMoreButtonTapped()
    func doneWithItemButtonTapped()
}

class WeighViewController: UIViewController, BluetoothManagerDelegate, WeighProcessDelegate {

    @IBOutlet weak var weighProcessView: WeighProcessView!
    var item = Item()
    let selectSizeView = SelectSizeView.ip_fromNib()
    let weighView = WeighView.ip_fromNib()
    let countingView = CountingView.ip_fromNib()
    let resultsView = ResultsView.ip_fromNib()
    
    let bluetoothManager = BluetoothManager.sharedInstance
    var weightReading: Double?
    var hasReading: Bool {
        return weightReading != nil
    }
    var selectedSizeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWeighProcessDelegates()
        setUpInitialView()
        setUpBluetooth()
    }
    
    func setUpWeighProcessDelegates() {
        selectSizeView.delegate = self
        resultsView.delegate = self
    }
    
    func setUpInitialView() {
        selectSizeView.configureForItem(item)
        weighProcessView.loadInitialView(selectSizeView)
    }
    
    func setUpBluetooth() {
        bluetoothManager.delegate = self
        bluetoothManager.prepareToConnectToScale()
    }
    
    // MARK: WeighProcessDelegate
    
    func selectSizeNextButtonTapped(sizeIndex: Int, inOut: Int) {
        guard sizeIndex > -1 && inOut > -1  else {
            self.presentViewController(UIAlertController.sizeAndWhichCountError(), animated: true, completion: nil)
            return
        }
        selectedSizeIndex = sizeIndex
        weighView.shirtsLabel.text = "Place \(item.sizes[sizeIndex].name) \(item.name)s On Scale"
        weighProcessView.currentView = weighView
    }
    
    func weighMoreButtonTapped() {
        // TODO: Remember size & count in/out
        weighProcessView.currentView = selectSizeView
        weightReading = nil
    }
    
    func doneWithItemButtonTapped() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: BluetoothManagerDelegate
    
    func gettingWeightReading() {
        weighProcessView.currentView = countingView
        print("Connected to scale & getting weight reading!")
    }
    
    func receivedWeightReadingInOunces(weight: Double) {
        if !hasReading {
            print("Weight reading: \(weight)")
            weightReading = weight
            resultsView.configureForWeight(weight, item: item, andSize: item.sizes[selectedSizeIndex])
            bluetoothManager.disconnectFromScale()
            weighProcessView.currentView = resultsView
        }
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
