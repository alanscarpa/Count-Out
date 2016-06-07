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
    let items = DataManager.sharedInstance.items
    
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
        tableView.registerNib(UINib(nibName: ReportsFooterView.ip_nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: ReportsFooterView.ip_nibName)
        tableView.registerNib(UINib(nibName: ReportsTableViewCell.ip_nibName, bundle: nil), forCellReuseIdentifier: ReportsTableViewCell.ip_nibName)
        

        let sendReportButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: #selector(sendReportButtonTapped))
        navigationItem.rightBarButtonItem = sendReportButton
    }
    
    func sendReportButtonTapped() {
        presentViewController(UIAlertController.dummyEmailSent(), animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].sizes.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?  {
        let headerFooterView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ReportsHeaderFooterView.ip_nibName) as! ReportsHeaderFooterView
        headerFooterView.itemNameLabel.text = items[section].name
        return headerFooterView
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ReportsFooterView.ip_nibName) as! ReportsFooterView
        footerView.grossTotalLabel.text = "Gross Amount Sold: $\(items[section].grossAmountSold)"
        return footerView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ReportsTableViewCell.ip_nibName) as! ReportsTableViewCell
        cell.configureForSize(items[indexPath.section].sizes[indexPath.row])
        return cell
    }

}
