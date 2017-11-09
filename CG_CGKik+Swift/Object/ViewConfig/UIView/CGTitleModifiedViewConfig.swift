//
//  CGTitleModifiedViewConfig.swift
//  QuickAskCommunity
//
//  Created by PCG on 2017/6/10.
//  Copyright © 2017年 ym. All rights reserved.
//

import UIKit

/** 带对称副视图的 线形副视图的配置 */
struct CGTitleModifiedLineViewConfig {
    
    let lineSize        : CGSize
    let backgroundColor : UIColor
    let cornerRadius    : CGFloat
    
    let titleSpace      : CGFloat
}

class CGTitleModifiedLineViewConfigModel: NSObject {
    
    var lineSize        : CGSize
    var backgroundColor : UIColor
    var cornerRadius    : CGFloat
    
    var titleSpace      : CGFloat
    
    var config : CGTitleModifiedLineViewConfig {
        return CGTitleModifiedLineViewConfig.init(lineSize: lineSize, backgroundColor: backgroundColor, cornerRadius: cornerRadius, titleSpace: titleSpace)
    }
    
    @objc init(lineSize: CGSize, backgroundColor: UIColor, cornerRadius: CGFloat, titleSpace: CGFloat) {
        
        self.lineSize           = lineSize;
        self.backgroundColor    = backgroundColor
        self.cornerRadius       = cornerRadius
        self.titleSpace         = titleSpace
        
        super.init()
    }
    
    
}
