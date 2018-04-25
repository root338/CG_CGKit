//
//  CGPointExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 ym. All rights reserved.
//

import Foundation

extension CGPoint {
    
    func cg_offset(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint.init(x: self.x + x, y: self.y + y)
    }
    
    func cg_offset(point: CGPoint) -> CGPoint {
        return CGPoint.init(x: self.x + point.x, y: self.y + point.y)
    }
}
