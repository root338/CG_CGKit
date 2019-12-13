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
    
    func ml_set(height: CGFloat, verticalAlignment: GMLEdgeVerticalType = GMLEdgeVerticalType.top, offset: CGFloat = 0) -> CGRect {
        var frame = self
        frame.size.height = height
        let originY : CGFloat
        switch verticalAlignment {
        case .top:
            originY = self.minY
        case .center:
            originY = self.midY - height / 2
        case .bottom:
            originY = self.maxY - height
        }
        frame.origin.y = originY + offset
        return frame
    }
    
    func ml_set(width: CGFloat, horizontalAlignment: GMLEdgeHorizontalType = GMLEdgeHorizontalType.top, offset: CGFloat = 0) -> CGRect {
        var frame = self
        frame.size.width = height
        let originX : CGFloat
        switch horizontalAlignment {
        case .top:
            originX = self.minX
        case .center:
            originX = self.midX - width / 2
        case .bottom:
            originX = self.maxX - width
        }
        frame.origin.x = originX + offset
        return frame
    }
}

//MARK:- 居中计算
extension CGRect {
    
    /// size 在 CGRect 中的居中区域
    func ml_centerRect(size: CGSize) -> CGRect {
        return CGRect.init(x: (self.size.width - size.width) / 2, y: (self.size.height - size.height) / 2, width: size.width, height: size.height)
    }
    
    /// size 在 CGRect 中的水平区域，需要提供 x
    func ml_horizontalCenterRect(size: CGSize, y: CGFloat, offsetX: CGFloat = 0) -> CGRect {
        return CGRect.init(x: (self.size.width - size.width) / 2, y: y, width: size.width, height: size.height)
    }
    /// size 在 CGRect 中的垂直区域，需要提供 y
    func ml_verticalCenterRect(size: CGSize, x: CGFloat, offsetY: CGFloat = 0) -> CGRect {
        return CGRect.init(x: x, y: (self.size.height - size.height) / 2, width: size.width, height: size.height)
    }
    func ml_horizontalFullRect(y: CGFloat, height: CGFloat) -> CGRect {
        return CGRect.init(x: self.minX, y: y, width: self.width, height: height)
    }
    func ml_verticalFullRect(x: CGFloat, width: CGFloat) -> CGRect {
        return CGRect.init(x: x, y: self.minY, width: width, height: self.height)
    }
}

extension CGRect {
    
    ///
    func ml_mirror(y: CGFloat) -> CGRect {
        var rect = self
        let originY : CGFloat
        
        if y <= self.minY {
            originY = y - self.height - (self.minY - y)
        }else if y >= self.maxY {
            originY = y + (y - self.maxY)
        }else if y < self.midY {
            originY = y - (y - self.minY)
        }else {
            originY = y - (self.maxY - y)
        }
        rect.origin.y = originY
        return rect
    }
    func ml_mirror(x: CGFloat) -> CGRect {
        var rect = self
        let originX : CGFloat
        if x <= self.minX {
            originX = x - self.width - (self.minX - x)
        }else if x >= self.maxX {
            originX = x + (x - self.maxX)
        }else if x < self.midX {
            originX = x - (x - self.minX)
        }else {
            originX = x - (self.maxX - x)
        }
        rect.origin.x = originX
        return rect
    }
    var ml_mirrorMaxY : CGRect {
        return ml_mirror(y: self.maxY)
    }
    var ml_mirrorMinY : CGRect {
        return ml_mirror(y: self.minY)
    }
    var ml_mirrorMaxX : CGRect {
        return ml_mirror(x: self.maxX)
    }
    var ml_mirrorMinX : CGRect {
        return ml_mirror(x: self.minX)
    }
}

extension CGRect {
    mutating func ml_setOffset(point: CGPoint) {
        self = ml_offset(point: point)
    }
}
