//
//  WeighViewController.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/25/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit
import CoreBluetooth

class CountViewController: UIViewController, BluetoothManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    let bluetoothManager = BluetoothManager.sharedInstance
    var items = [Item]()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = "Count"
        navigationItem.title = title?.uppercaseString
        tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(named: "countTab"),
            tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: CountHeaderFooterView.ip_nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: CountHeaderFooterView.ip_nibName)
        tableView.registerNib(UINib(nibName: CountTableViewCell.ip_nibName, bundle: nil), forCellReuseIdentifier: CountTableViewCell.ip_nibName)
        items = [
            Item(name: "Black FOB Skull Shirt", sizes: ["S", "M", "L", "XL", "XXL"], image: UIImage(named: "itemImage1")),
            Item(name: "Red Crossbones Hoodie", sizes: ["S", "M", "L", "XL", "XXL"], image: UIImage(named: "itemImage3")),
            Item(name: "Ladies Blue Tank Top", sizes: ["S", "M", "L", "XL", "XXL"], image: UIImage(named: "itemImage4")),
            Item(name: "Tour Tee", sizes: ["S", "M", "L", "XL", "XXL"], image: UIImage(named: "itemImage6")),
            Item(name: "High Flying Eagle Shirt", sizes: ["S", "M", "L", "XL", "XXL"], image: UIImage(named: "itemImage2")),
            Item(name: "American Flag Hoodie", sizes: ["S", "M", "L", "XL", "XXL"], image: UIImage(named: "itemImage5"))
        ]
        setUpBluetooth()
    }
    
    func setUpBluetooth() {
        bluetoothManager.delegate = self
        bluetoothManager.prepareToConnectToScale()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?  {
        let headerFooterView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(CountHeaderFooterView.ip_nibName) as! CountHeaderFooterView
        return headerFooterView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CountTableViewCell.ip_nibName) as! CountTableViewCell
        cell.configureForItem(items[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        navigationController?.pushViewController(WeighViewController.ip_fromNib(), animated: true)
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
