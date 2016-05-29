//
//  WeighViewController.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/29/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class WeighViewController: UIViewController {

    @IBOutlet weak var weighViewContainer: UIView!
    let selectSizeView = SelectSizeView.ip_fromNib()
    let weighView = WeighView.ip_fromNib()
    let countingView = CountingView.ip_fromNib()
    let resultsView = ResultsView.ip_fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weighViewContainer.addSubview(selectSizeView)
        selectSizeView.autoPinEdgesToSuperviewEdges()
        
    }

}
