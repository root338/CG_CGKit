//
//  MLColorExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 ym. All rights reserved.
//

import Foundation

extension UIColor {
    
    open func ml_getRGB() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        
        var red : CGFloat   = 0
        var green : CGFloat = 0
        var blue : CGFloat  = 0
        var alpha : CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}
