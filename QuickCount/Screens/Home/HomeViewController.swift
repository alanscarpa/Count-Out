//
//  HomeViewController.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/25/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = "Home"
        navigationItem.titleView = UIImageView(image: UIImage(named: "topBarLogo"))
        tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(named: "homeTab"),
            tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(
            UINib(nibName: HomeTableViewCell.ip_nibName, bundle: nil),
            forCellReuseIdentifier: HomeTableViewCell.ip_nibName
        )
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeTableViewCell.ip_nibName, forIndexPath: indexPath) as! HomeTableViewCell
        // TODO: FOR DEMO PURPOSES ONLY - CHANGE ONCE WE HAVE DATA SOURCE.
        if indexPath.row == 1 {
            cell.configureForBarclays()
        }
        return cell
    }

}
