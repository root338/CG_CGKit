//
//  MLSizeExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/8/9.
//  Copyright © 2018年 ym. All rights reserved.
//

import Foundation
//MARK:- 静态初始化方法
extension CGSize {
    
    static var maxSize : CGSize {
        return CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    }
    
}

//MARK:- 扩展方法
extension CGSize {
    
    var ml_areaGreaterZero : Bool {
        let minValue = CGFloat.leastNormalMagnitude
        return self.width > minValue && self.height > minValue
    }
    
    func ml_add(value: CGFloat) -> CGSize {
        return CGSize(width: self.width + value,
                      height: self.height + value)
    }
    func ml_add(size: CGSize) -> CGSize {
        return CGSize(width: self.width + size.width,
                      height: self.height + size.height)
    }
    
    /// 加一个UIEdgeInsets
    func ml_add(insets: UIEdgeInsets) -> CGSize {
        return CGSize(width: self.width + insets.cg_horizontalValue,
                      height: self.height + insets.cg_verticalValue)
    }
    /// 小于 maxSize
    func ml_lessThan(_ size: CGSize) -> CGSize {
        return CGSize(width: min(self.width, size.width), height: min(self.height, size.height))
    }
    /// 大于 minSize
    func ml_greaterThan(_ size: CGSize) -> CGSize {
        return CGSize(width: max(self.width, size.width),
                      height: max(self.height, size.height))
    }
    /// 减一个UIEdgeInsets
    func ml_less(insets: UIEdgeInsets) -> CGRect {
        return CGRect(x: insets.left,
                      y: insets.top,
                      width: self.width - insets.cg_horizontalValue,
                      height: self.height - insets.cg_verticalValue)
    }
    /// 减 size
    func ml_less(size: CGSize) -> CGSize {
        return CGSize(width: self.width - size.width,
                      height: self.height - size.height)
    }
    
    func set(width: CGFloat) -> CGSize {
        return CGSize.init(width: width, height: self.height)
    }
    func minWidth(_ width: CGFloat) -> CGSize {
        return CGSize.init(width: max(self.width, width), height: self.height)
    }
    func maxWidth(_ width: CGFloat) -> CGSize {
        return CGSize.init(width: min(self.width, width), height: self.height)
    }
    
    func set(height: CGFloat) -> CGSize {
        return CGSize.init(width: self.width, height: height)
    }
    func minHeight(_ height: CGFloat) -> CGSize {
        return CGSize.init(width: self.width, height: max(self.height, height))
    }
    func maxHeight(_ height: CGFloat) -> CGSize {
        return CGSize.init(width: self.width, height: min(self.height, height))
    }
}
