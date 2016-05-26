//
//  RootViewController.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/24/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit
import Intrepid
import PureLayout

class RootViewController: UIViewController {
    
    let loginViewController = LoginViewController.ip_fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoginViewController()
    }
    
    func showLoginViewController() {
        ip_addChildViewController(loginViewController)
        loginViewController.view.autoPinEdgesToSuperviewEdges()
    }
}