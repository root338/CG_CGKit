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
    
    /// 加一个UIEdgeInsets
    func ml_add(insets: UIEdgeInsets) -> CGSize {
        return CGSize.init(width: self.width + insets.cg_horizontalValue,
                           height: self.height + insets.cg_verticalValue)
    }
    /// 小于 maxSize
    func ml_lessThan(_ size: CGSize) -> CGSize {
        return CGSize.init(width: min(self.width, size.width), height: min(self.height, size.height))
    }
    /// 大于 minSize
    func ml_greaterThan(_ size: CGSize) -> CGSize {
        return CGSize.init(width: max(self.width, size.width),
                           height: max(self.height, size.height))
    }
    /// 减一个UIEdgeInsets
    func ml_less(insets: UIEdgeInsets) -> CGRect {
        return CGRect.init(x: insets.left,
                           y: insets.top,
                           width: self.width - insets.cg_horizontalValue,
                           height: self.height - insets.cg_verticalValue)
    }
}
