//
//  CGViewExtension.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/12/13.
//  Copyright © 2017年 ym. All rights reserved.
//

import Foundation

//MARK:- 布局
extension UIView {
    
    open func ml_set(frame: CGRect, addTo superview: UIView? = nil) {
        if !frame.equalTo(self.frame) {
            self.frame = frame
        }
        
        if superview != nil && self.superview != superview {
            superview!.addSubview(self)
        }
        if self.isHidden {
            self.isHidden = false
        }
    }
}

//MARK:- 常量
extension UIView {
    var ml_estimatedMaxSize : CGSize {
        return CGSize.init(width: self.width, height: CGFloat.greatestFiniteMagnitude)
    }
    func ml_estimatedSize(width: CGFloat) -> CGSize {
        return CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude)
    }
}