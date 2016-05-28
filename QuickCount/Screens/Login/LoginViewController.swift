//
//  ViewController.swift
//  Counted
//
//  Created by Alan Scarpa on 5/15/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit
import CoreBluetooth
import MediaPlayer
import PureLayout

class LoginViewController: UIViewController, BluetoothManagerDelegate {
    let bluetoothManager = BluetoothManager.sharedInstance
    var player = MPMoviePlayerController()
    
    let mainVC = MainViewController.ip_fromNib()
    var bottomConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBluetooth()
        setUpBackgroundVideo()
    }
    
    func setUpBluetooth() {
        bluetoothManager.delegate = self
        bluetoothManager.connectToScale()
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
    
    func setUpMainViewController() {
        ip_addChildViewController(mainVC)
        bottomConstraint = mainVC.view.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self.view, withOffset: -self.view.ip_height)
        mainVC.view.autoAlignAxisToSuperviewAxis(.Vertical)
        mainVC.view.autoSetDimensionsToSize(self.view.ip_frameSize)
    }
    
    // MARK: Actions
    
    @IBAction func logInButtonTapped(sender: AnyObject) {
        // TODO:  Only set up if login was successful
        setUpMainViewController()
        self.view.layoutSubviews()
        
        UIView.animateWithDuration(0.5, animations: {
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
            }) { finished in
               self.clearLoginInformation()
                // TODO: Stop video playback & resume on returning
        }
    }
    
    func clearLoginInformation() {
        // TODO: Clear login info
    }
    
    // MARK: BluetoothManagerDelegate
    
    func gettingWeightReading() {
        print("Connected to scale & getting weight reading!")
    }
    
    func receivedWeightReading(weight: String) {
        // TODO: Only get 1 weight reading
        print(weight)
    }
    
    func receivedBluetoothError(error: NSError) {
        if let errorMessage = error.userInfo[NSLocalizedDescriptionKey] as? String {
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                self.presentViewController(UIAlertController.bluetoothErrorWithMessage(errorMessage), animated: true, completion: nil)
            })
        }
    }
    
    func receivedUserBluetoothError(errorState: CBCentralManagerState) {
        // TODO: Maybe show a modal, preventing user from attempting to use scale until Bluetooth is enabled
        switch errorState {
        case .PoweredOff:
            break
        case .Unsupported:
            break
        case .Unauthorized:
            break
        default:
            break
        }
    }
    
    func userEnabledBluetooth() {
        // TODO: Dismiss modal instructing user to turn on bluetooth if it exists?
    }
    
}

