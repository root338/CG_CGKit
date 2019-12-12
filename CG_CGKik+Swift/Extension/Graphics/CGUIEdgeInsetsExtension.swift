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
    init(value: CGFloat, type: GMLEdgeType) {
        switch type {
        case .top:
            self.init(top: value, left: 0, bottom: 0, right: 0)
        case .bottom:
            self.init(top: 0, left: 0, bottom: value, right: 0)
        case .left:
            self.init(top: value, left: value, bottom: 0, right: 0)
        case .right:
            self.init(top: value, left: 0, bottom: 0, right: value)
        }
    }
    
    init(horizontalValue value: CGFloat) {
        self.init(top: 0, left: value, bottom: 0, right: value)
    }
    
    init(verticalValue value: CGFloat) {
        self.init(top: value, left: 0, bottom: value, right: 0)
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
