//
//  QCNavigationBar.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/28/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class QCNavigationBar: UINavigationBar {

    let kNavBarHeight: CGFloat = 44
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        let newSize = CGSizeMake(self.frame.size.width, kNavBarHeight)
        return newSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

}
