//
//  CGUIEdgeInsetsExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/4/20.
//  Copyright © 2018年 ym. All rights reserved.
//

import Foundation

//MARK:- 初始化方法
extension UIEdgeInsets {
    
    init(value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
    init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
        self.init(top: top ?? 0,
                  left: left ?? 0,
                  bottom: bottom ?? 0,
                  right: right ?? 0)
    }
    init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil, other: CGFloat) {
        self.init(top: top ?? other,
                  left: left ?? other,
                  bottom: bottom ?? other,
                  right: right ?? other)
    }
    
    init(value: CGFloat, type: GMLEdgeType) {
        switch type {
        case .top:
            self.init(top: value, left: 0, bottom: 0, right: 0)
        case .bottom:
            self.init(top: 0, left: 0, bottom: value, right: 0)
        case .left:
            self.init(top: 0, left: value, bottom: 0, right: 0)
        case .right:
            self.init(top: 0, left: 0, bottom: 0, right: value)
        }
    }
    
    init(horizontalValue value: CGFloat, top: CGFloat = 0, bottom: CGFloat = 0) {
        self.init(top: top, left: value, bottom: bottom, right: value)
    }
    
    init(verticalValue value: CGFloat, left: CGFloat = 0, right: CGFloat = 0) {
        self.init(top: value, left: left, bottom: value, right: right)
    }
    init(left: CGFloat, right: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: right)
    }
    init(top: CGFloat, bottom: CGFloat) {
        self.init(top: top, left: 0, bottom: bottom, right: 0)
    }
    init(horizontalValue: CGFloat, verticalValue: CGFloat) {
        self.init(top: verticalValue, left: horizontalValue, bottom: verticalValue, right: horizontalValue)
    }
}
//MARK:- 扩展方法
extension UIEdgeInsets {
    var cg_horizontalValue: CGFloat {
        return self.left + self.right
    }
    var cg_verticalValue: CGFloat {
        return self.top + self.bottom
    }
    var cg_point : CGPoint {
        return CGPoint.init(x: self.left, y: self.top)
    }
}
