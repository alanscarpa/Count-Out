//
//  QCNavigationController.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/28/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class QCNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {    
        super.init(navigationBarClass: QCNavigationBar.self, toolbarClass: nil)
        self.setViewControllers([rootViewController], animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

}
