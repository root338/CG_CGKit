//
//  GesturesExtension.swift
//  CGPhoto
//
//  Created by DY on 2017/11/23.
//  Copyright © 2017年 DY. All rights reserved.
//

import Foundation

//MARK:- 创建方法


//MARK:- UIGestureRecognizer功能扩展
extension UIGestureRecognizer {
    
    
    /// 获取所有点的中点
    func allTouchesLocationCenterPoint(in view: UIView?) -> CGPoint {
        
        var centerPoint : CGPoint
        if self.numberOfTouches > 0 {
            
            centerPoint = CGPoint.zero
            for i in 0 ..< self.numberOfTouches {
                
                let point   = self.location(ofTouch: i, in: view)
                if i == 0 {
                    centerPoint = point
                }else {
                    
                    centerPoint = CGPoint.cg_centerPoint(point1: centerPoint, point2: point)
                }
            }
        }else {
            
            centerPoint = self.location(in: view)
        }
        
        return centerPoint
    }
    
}
