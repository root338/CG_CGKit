//
//  CGPointExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 ym. All rights reserved.
//

import Foundation

enum MLOffsetType : Int {
    case add
    case less
}

extension CGPoint {
    
    func ml_offset(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint.init(x: self.x + x, y: self.y + y)
    }
    
    func ml_offset(point: CGPoint) -> CGPoint {
        return CGPoint.init(x: self.x + point.x, y: self.y + point.y)
    }
    
    func ml_offsetLess(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint.init(x: self.x - x, y: self.y - y)
    }
    
    func ml_offsetLess(point: CGPoint) -> CGPoint {
        return CGPoint.init(x: self.x - point.x, y: self.y - point.y)
    }
    
    mutating func ml_mutableOffset(x: CGFloat, y: CGFloat) {
        self = ml_offset(x: x, y: y)
    }
    
    mutating func ml_mutableOffset(point: CGPoint) {
        self = ml_offset(point: point)
    }
    
    mutating func ml_mutableOffsetLess(x: CGFloat, y: CGFloat) {
        self = ml_offsetLess(x: x, y: y)
    }
    
    mutating func ml_mutableOffsetLess(point: CGPoint) {
        self = ml_offsetLess(point: point)
    }
}
