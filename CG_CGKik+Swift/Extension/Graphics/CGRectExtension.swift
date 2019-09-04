//
//  CGRectExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 ym. All rights reserved.
//

import Foundation

extension CGRect {
    
    func ml_centerRect(size: CGSize) -> CGRect {
        return CGRect.init(x: (self.size.width - size.width) / 2, y: (self.size.height - size.height) / 2, width: size.width, height: size.height)
    }
    
    func ml_offset(point: CGPoint) -> CGRect {
        var rect = self
        rect.origin = CGPoint.init(x: self.minX + point.x, y: self.minY + point.y)
        return rect
    }
    
    /// 为Rect排除外边距 {x + left, y + top, x - (left + right), y - (top + bottom)}
    func ml_exclude(marginInsets insets: UIEdgeInsets) -> CGRect {
        return CGRect.init(x: self.minX + insets.left, y: self.minY + insets.top, width: self.width - insets.left - insets.right, height: self.height - insets.top - insets.bottom)
    }
    
    /// 为Rect增加外边距 {x - left, y - top, x + (left + right), y + (top + bottom)}
    func ml_add(marginInsets insets: UIEdgeInsets) -> CGRect {
        return CGRect.init(x: self.minX - insets.left, y: self.minY - insets.top, width: self.width + insets.left + insets.right, height: self.height + insets.top + insets.bottom)
    }
}

extension CGRect {
    mutating func ml_setOffset(point: CGPoint) {
        self = ml_offset(point: point)
    }
}
