//
//  CGRectExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 ym. All rights reserved.
//

import Foundation

extension CGRect {
    
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

//MARK:- 居中计算
extension CGRect {
    
    /// size 在 CGRect 中的居中区域
    func ml_centerRect(size: CGSize) -> CGRect {
        return CGRect.init(x: (self.size.width - size.width) / 2, y: (self.size.height - size.height) / 2, width: size.width, height: size.height)
    }
    
    /// size 在 CGRect 中的水平区域，需要提供 x
    func ml_horizontalCenterRect(size: CGSize, x: CGFloat) -> CGRect {
        return CGRect.init(x: x, y: (self.size.height - size.height) / 2, width: size.width, height: size.height)
    }
    /// size 在 CGRect 中的垂直区域，需要提供 y
    func ml_verticalCenterRect(size: CGSize, y: CGFloat) -> CGRect {
        return CGRect.init(x: (self.size.width - size.width) / 2, y: y, width: size.width, height: size.height)
    }
}


extension CGRect {
    mutating func ml_setOffset(point: CGPoint) {
        self = ml_offset(point: point)
    }
}
