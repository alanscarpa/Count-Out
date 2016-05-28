//
//  QCLabel.swift
//  QuickCount
//
//  Created by Alan Scarpa on 5/28/16.
//  Copyright © 2016 Counted. All rights reserved.
//

import UIKit

class QCLabel: UILabel {

    var edgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRectForBounds(UIEdgeInsetsInsetRect(bounds, edgeInsets), limitedToNumberOfLines: numberOfLines)
        
        rect.origin.x -= edgeInsets.left
        rect.origin.y -= edgeInsets.top
        rect.size.width  += (edgeInsets.left + edgeInsets.right);
        rect.size.height += (edgeInsets.top + edgeInsets.bottom);
        
        return rect
    }
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, edgeInsets))
    }
    
    func setUp() {
        backgroundColor = UIColor.qcBlackTransparent()
        textColor = UIColor.qcWhite()
        font = UIFont.qcDosisLight(20)
    }

}
