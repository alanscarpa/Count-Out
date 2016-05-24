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

class LoginViewController: UIViewController, BluetoothManagerDelegate {
    let bluetoothManager = BluetoothManager.sharedInstance
    var player = MPMoviePlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bluetoothManager.delegate = self
        bluetoothManager.connectToScale()
        
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
        blurEffectView.alpha = 0.3
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.view.insertSubview(blurEffectView, atIndex: 1)
    }
    
    @IBAction func logInButtonTapped(sender: AnyObject) {
        
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

