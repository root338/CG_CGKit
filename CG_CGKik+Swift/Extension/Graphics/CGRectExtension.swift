//
//  CGRectExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 ym. All rights reserved.
//

import UIKit

extension CGRect {
    
    var ml_bounds: CGRect {
        return CGRect(origin: .zero, size: self.size)
    }
    
    func ml_offset(point: CGPoint) -> CGRect {
        var rect = self
        rect.origin = CGPoint.init(x: self.minX + point.x, y: self.minY + point.y)
        return rect
    }
    func ml_offsetY(_ y: CGFloat) -> CGRect {
        var rect = self
        rect.origin.y += y
        return rect
    }
    func ml_offsetX(_ x: CGFloat) -> CGRect {
        var rect = self
        rect.origin.x += x
        return rect
    }
    
    /// 为Rect排除外边距 {x + left, y + top, width - (left + right), height - (top + bottom)}
    func ml_exclude(marginInsets insets: UIEdgeInsets) -> CGRect {
        return CGRect.init(x: self.minX + insets.left, y: self.minY + insets.top, width: self.width - insets.left - insets.right, height: self.height - insets.top - insets.bottom)
    }
    
    /// 为Rect增加外边距 {x - left, y - top, width + (left + right), height + (top + bottom)}
    func ml_add(marginInsets insets: UIEdgeInsets) -> CGRect {
        return CGRect.init(x: self.minX - insets.left, y: self.minY - insets.top, width: self.width + insets.left + insets.right, height: self.height + insets.top + insets.bottom)
    }
    
    /// 设置 CGRect 的 y 和 height
    /// - Parameters:
    ///   - verticalAlignment: y 的垂直对齐方式，随着该值的变化，起始 y 值会不同
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
    
    /// 设置 CGRect 的 x 和 width
    /// - Parameters:
    ///   - horizontalAlignment: x 的水平对齐方式，随着该值的变化，起始 x 值会不同
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

//MARK:- 对齐计算
extension CGRect {
    
    /// size 在 CGRect 中的居中区域
    func ml_centerRect(size: CGSize, offset: CGPoint = CGPoint.zero) -> CGRect {
        return CGRect.init(x: self.minX + (self.size.width - size.width) / 2 + offset.x, y: self.minY + (self.size.height - size.height) / 2 + offset.y, width: size.width, height: size.height)
    }
    
    /// rect 内指定 size 在不同填充下的 rect 值
    func ml_size(_ size: CGSize, contentMode: UIView.ContentMode, offset: CGPoint = CGPoint.zero) -> CGRect {
        
        var x : CGFloat = 0
        var y : CGFloat = 0
        var width = size.width
        var height = size.height
        
        switch contentMode {
        case .scaleToFill:
            width = self.width
            height = self.height
        case .scaleAspectFit: fallthrough
        case .scaleAspectFill:
            let s1 = size.width / self.width
            let s2 = size.height / self.height
            if (s1 < s2) {
                if (contentMode == .scaleAspectFit) {
                    width   = size.width / s2;
                    height  = size.height;
                }else {
                    width   = size.width;
                    height  = size.height / s1;
                }
            }else {
                if (contentMode == .scaleAspectFit) {
                    width   = size.width;
                    height  = size.height / s1;
                }else {
                    width   = size.width / s2;
                    height  = size.height;
                }
            }
            x = self.width.mid(lessValue: width)
            y = self.height.mid(lessValue: height)
        case .redraw: break
        case .center: return ml_centerRect(size: size)
        case .top:
            x = self.width.mid(lessValue: width)
        case .bottom:
            x = self.width.mid(lessValue: width)
            y = self.height - height
        case .left:
            y = self.height.mid(lessValue: height)
        case .right:
            x = self.width - width
            y = self.height.mid(lessValue: height)
        case .topLeft: break
        case .topRight:
            x = self.width - width
        case .bottomLeft:
            y = self.height - height
        case .bottomRight:
            x = self.width - width
            y = self.height - height
        @unknown default: break
        }
        return CGRect(x: x + self.minX + offset.x, y: y + self.minY + offset.y, width: width, height: height)
    }
    
    /// size 在 CGRect 中的水平区域，需要提供 x
    func ml_horizontalCenterRect(size: CGSize, y: CGFloat, offsetX: CGFloat = 0) -> CGRect {
        return CGRect.init(x: (self.size.width - size.width) / 2, y: y, width: size.width, height: size.height)
    }
    /// size 在 CGRect 中的垂直区域，需要提供 y
    func ml_verticalCenterRect(size: CGSize, x: CGFloat, offsetY: CGFloat = 0) -> CGRect {
        return CGRect.init(x: x, y: (self.size.height - size.height) / 2, width: size.width, height: size.height)
    }
    /// 水平填充满，并设置自定义的 y 和 height
    func ml_horizontalFullRect(y: CGFloat, height: CGFloat) -> CGRect {
        return CGRect.init(x: self.minX, y: y, width: self.width, height: height)
    }
    /// 垂直填充满，并设置自定义的 x 和 width
    func ml_verticalFullRect(x: CGFloat, width: CGFloat) -> CGRect {
        return CGRect.init(x: x, y: self.minY, width: width, height: self.height)
    }
}

extension CGRect {
    
    /// 已给定 y 轴值转换的镜像
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
    /// 已给定 x 轴值转换的镜像
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
    /// 以 maxY 值为轴，转换的镜像（向下翻转）
    var ml_mirrorMaxY : CGRect {
        return ml_mirror(y: self.maxY)
    }
    /// 以 minY 值为轴，转换的镜像（向上翻转）
    var ml_mirrorMinY : CGRect {
        return ml_mirror(y: self.minY)
    }
    /// 以 maxX 值为轴，转换的镜像（向右翻转）
    var ml_mirrorMaxX : CGRect {
        return ml_mirror(x: self.maxX)
    }
    /// 以 minX 值为轴，转换的镜像（向左翻转）
    var ml_mirrorMinX : CGRect {
        return ml_mirror(x: self.minX)
    }
}

extension CGRect {
    mutating func ml_setOffset(point: CGPoint) {
        self = ml_offset(point: point)
    }
}
