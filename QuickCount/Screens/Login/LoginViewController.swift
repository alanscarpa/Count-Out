//
//  ViewController.swift
//  Counted
//
//  Created by Alan Scarpa on 5/15/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit
import MediaPlayer
import PureLayout

class LoginViewController: UIViewController {
    var player = MPMoviePlayerController()
    
    let mainVC = MainViewController.ip_fromNib()
    var bottomConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackgroundVideo()
    }
    
    func setUpBackgroundVideo() {
        if let path = NSBundle.mainBundle().pathForResource("loginVideo", ofType:"mp4") {
            let url = NSURL.fileURLWithPath(path)
            player = MPMoviePlayerController(contentURL: url)
            player.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            player.view.sizeToFit()
            player.scalingMode = MPMovieScalingMode.AspectFill
            player.fullscreen = true
            player.controlStyle = MPMovieControlStyle.None
            player.movieSourceType = MPMovieSourceType.File
            player.repeatMode = MPMovieRepeatMode.One
            player.play()
            self.view.insertSubview(player.view, atIndex: 0)
        }
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.view.insertSubview(blurEffectView, atIndex: 1)
    }
    
    // MARK: Actions
    
    @IBAction func logInButtonTapped(sender: AnyObject) {
        // TODO:  Only set up if login was successful
        setUpMainViewController()
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.5, animations: {
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
            }) { finished in
               self.clearLoginInformation()
                // TODO: Stop video playback & resume on returning
        }
    }
    
    func setUpMainViewController() {
        ip_addChildViewController(mainVC)
        bottomConstraint = mainVC.view.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self.view, withOffset: -self.view.ip_height)
        mainVC.view.autoAlignAxisToSuperviewAxis(.Vertical)
        mainVC.view.autoSetDimensionsToSize(self.view.ip_frameSize)
    }
    
    func clearLoginInformation() {
        // TODO: Clear login info
    }
    
}

