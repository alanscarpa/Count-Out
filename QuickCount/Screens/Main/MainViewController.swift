//
//  MainViewController.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/25/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let mainTabBarController = UITabBarController()
    
    let homeViewController = QCNavigationController(rootViewController: HomeViewController.ip_fromNib())
    let weighViewController = QCNavigationController(rootViewController: WeighViewController.ip_fromNib())
    let reportsViewController = QCNavigationController(rootViewController: ReportsViewController.ip_fromNib())
    let settingsViewController = QCNavigationController(rootViewController: SettingsViewController.ip_fromNib())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    func setUpTabBar() {
        mainTabBarController.viewControllers = [homeViewController, weighViewController, reportsViewController, settingsViewController]
        ip_addChildViewController(mainTabBarController)
        mainTabBarController.view.autoPinEdgesToSuperviewEdges()
    }

}
