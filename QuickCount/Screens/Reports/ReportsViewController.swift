//
//  ReportsViewController.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/25/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = "Reports"
        navigationItem.title = title?.uppercaseString
        tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(named: "reportTab"),
            tag: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: ReportsHeaderFooterView.ip_nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: ReportsHeaderFooterView.ip_nibName)
        tableView.registerNib(UINib(nibName: ReportsTableViewCell.ip_nibName, bundle: nil), forCellReuseIdentifier: ReportsTableViewCell.ip_nibName)
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?  {
        let headerFooterView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ReportsHeaderFooterView.ip_nibName) as! ReportsHeaderFooterView
        return headerFooterView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ReportsTableViewCell.ip_nibName) as! ReportsTableViewCell
//        cell.configureForItem(items[indexPath.row])
        return cell
    }

}
