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
    
    let vc1 = HomeViewController.ip_fromNib()
    let vc2 = WeighViewController.ip_fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mainTabBarController.viewControllers = [vc1, vc2]
        mainTabBarController.selectedIndex = 0
        ip_addChildViewController(mainTabBarController)
        mainTabBarController.view.autoPinEdgesToSuperviewEdges()
    }

}
