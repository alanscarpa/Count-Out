//
//  ViewController.swift
//  Counted
//
//  Created by Alan Scarpa on 5/15/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let btDiscovery = BTDiscovery.sharedManager
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotifications()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: Notifications
    
    func registerNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didConnectToScale), name: kDidConnectToScale, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didDisconnectFromScale), name: kDidDisconnectFromScale, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didReceiveWeightReading(_:)), name: kDidGetWeightReading, object: nil)
    }
    
    func didConnectToScale() {
        print("Connected to scale!")
    }
    
    func didDisconnectFromScale() {
        print("Disconnected from scale!")
    }
    
    func didReceiveWeightReading(notification: NSNotification) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            if let weight = notification.userInfo?["weight"] as? Double {
                self.weightLabel.text = String(format:"%.2f", weight)
            }
        }
    }

}

