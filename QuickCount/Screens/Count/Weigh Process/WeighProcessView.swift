//
//  WeighProcessView.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/29/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class WeighProcessView: UIView {

    private var previousView: UIView?
    private var kAnimationTime = 0.6
    
    var currentView = UIView() {
        didSet {
            if previousView == nil {
                self.addSubview(currentView)
                currentView.autoPinEdgesToSuperviewEdges()
                previousView = currentView
            } else {
                transitionToView(currentView)
            }
        }
    }
    
    func loadInitialView(view: UIView) {
        currentView = view
    }
    
    private func transitionToView(nextView: UIView) {
        UIView.animateWithDuration(kAnimationTime, animations: {
            self.previousView!.alpha = 0.1
        }) { (finished) in
            self.previousView!.removeFromSuperview()
            nextView.alpha = 0.1
            self.addSubview(nextView)
            nextView.autoPinEdgesToSuperviewEdges()
            UIView.animateWithDuration(self.kAnimationTime, animations: {
                nextView.alpha = 1
            }) { (finished) in
                self.previousView = nextView
            }
        }
    }
    
}
