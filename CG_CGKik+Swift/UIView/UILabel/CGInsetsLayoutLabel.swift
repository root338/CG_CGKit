//
//  CGInsetsLayoutLabel.swift
//  QuickAskCommunity
//
//  Created by PCG on 2017/7/4.
//  Copyright © 2017年 ym. All rights reserved.
//

import UIKit

class CGInsetsLayoutLabel: UILabel {

    var verticalSpace : CGFloat   = 0
    @objc var horizontalSpace : CGFloat = 0
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        
        contentSize.height += verticalSpace
        contentSize.width += horizontalSpace
        
        return contentSize
    }
    
    
}
