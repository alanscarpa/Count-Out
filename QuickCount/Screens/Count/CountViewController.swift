//
//  WeighViewController.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/25/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class CountViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
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
        setUpTableView()
        setUpDummyData()
    }
    
    func setUpTableView() {
        tableView.registerNib(UINib(nibName: CountHeaderFooterView.ip_nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: CountHeaderFooterView.ip_nibName)
        tableView.registerNib(UINib(nibName: CountTableViewCell.ip_nibName, bundle: nil), forCellReuseIdentifier: CountTableViewCell.ip_nibName)
    }
    
    func setUpDummyData() {
        let small = Size(name: "S", weightInOunces: 16)
        let medium = Size(name: "M", weightInOunces: 6.7)
        let large = Size(name: "L", weightInOunces: 7.7)
        let extraLarge = Size(name: "XL", weightInOunces: 9.7)
        items = [
            Item(name: "Black FOB Skull Shirt", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage1")),
            Item(name: "Red Crossbones Hoodie", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage3")),
            Item(name: "Ladies Blue Tank Top", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage4")),
            Item(name: "Tour Tee", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage6")),
            Item(name: "High Flying Eagle Shirt", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage2")),
            Item(name: "American Flag Hoodie", sizes: [small, medium, large, extraLarge], image: UIImage(named: "itemImage5"))
        ]
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
        let weighVC = WeighViewController.ip_fromNib()
        weighVC.item = items[indexPath.row]
        navigationController?.pushViewController(weighVC, animated: true)
    }

}
