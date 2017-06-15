//
//  CGSemicircleLabel.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/6/15.
//  Copyright © 2017年 ym. All rights reserved.
//

import UIKit

class CGSemicircleLabel: UILabel {

    /// 是否设置圆角, 默认为 true
    var isAutoSemicircle        = true
    /// 圆角为高度的比例，不小于 1， 默认为 2
    var cornerRadiusScale   = CGFloat(2)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cornerRadius    = cornerRadiusScale != 0.0 ? (frame.size.height / cornerRadiusScale) : 0
        self.cornerRadius   = cornerRadius
    }

}
