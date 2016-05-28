//
//  QCNavigationBar.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/28/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class QCNavigationBar: UINavigationBar {

    let kNavBarHeight: CGFloat = 30
    
//    lazy var nowPlayingImageView: WNYCImageView = {
//        let nowPlayingImageView = WNYCImageView()
//        nowPlayingImageView.userInteractionEnabled = true
//        nowPlayingImageView.autoSetDimensionsToSize(CGSize(width: 28, height: 17))
//        return nowPlayingImageView
//    }()
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        let newSize = CGSizeMake(self.frame.size.width, kNavBarHeight)
        return newSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.addSubview(nowPlayingImageView)
//        configureNowPlayingIconState()
//        
//        // TODO: Remove these 2 lines when we begin fetching audio from network.  Only here so we can access expanded player.
//        nowPlayingImageView.image = UIImage.animatedImageNamed("bTNNowPlaying-", duration: 0.7)
//        nowPlayingImageView.hidden = false
//        
//        nowPlayingImageView.autoPinEdge(.Top, toEdge: .Top, ofView: self, withOffset: 8)
//        nowPlayingImageView.autoPinEdge(.Trailing, toEdge: .Trailing, ofView: self, withOffset: -20)
//        
//        nowPlayingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(WNYCNavigationBar.didTapNowPlayingImageView)))
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WNYCNavigationBar.configureNowPlayingIconState), name: PlaybackManagerStateChangedNotification, object: nil)
    }

}
