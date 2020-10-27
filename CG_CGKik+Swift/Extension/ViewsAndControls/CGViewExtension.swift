//
//  CGViewExtension.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/12/13.
//  Copyright © 2017年 ym. All rights reserved.
//

import Foundation

//MARK:- 设置布局
public extension UIView {
    
    var viewableAreaNotZero : Bool {
        let size = self.frame.size
        return size.ml_areaGreaterZero
    }
    
    func ml_set(frame: CGRect, addTo superview: UIView? = nil, isHidden: Bool? = false) {
        if !frame.equalTo(self.frame) {
            self.frame = frame
        }
        
        if superview != nil && self.superview != superview {
            superview!.addSubview(self)
        }
        if isHidden != nil {
            if self.isHidden != isHidden! {
                self.isHidden = isHidden!
            }
        }
    }
    
    /// 设置UIView的frame，hidden，当isHidden == true 时，不设置 frame
    func ml_set(isHidden: Bool, frame: CGRect) {
        if self.isHidden != isHidden {
            self.isHidden = isHidden
        }
        if isHidden {
            return
        }
        if !frame.equalTo(self.frame) {
            self.frame = frame
        }
    }
    
    func ml_set(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        let oldFrame = self.frame
        let frame = CGRect(x: x ?? oldFrame.minX,
                              y: y ?? oldFrame.minY,
                              width: width ?? oldFrame.width,
                              height: height ?? oldFrame.height)
        if oldFrame.equalTo(frame) {
            return
        }
        self.frame = oldFrame
    }
    
    /// 设置 frame，并插入到视图的指定索引
    func ml_set(frame: CGRect, insertTo superview: UIView? = nil, at index: Int = 0, isHidden: Bool? = nil) {
        if !frame.equalTo(self.frame) {
            self.frame = frame
        }
        if isHidden != nil && self.isHidden != isHidden! {
            self.isHidden = isHidden!
        }
        guard let view = superview else { return }
        let subviewsCount = view.subviews.count
        let targetIndex = max(0, min(index, subviewsCount - 1))
        if subviewsCount > 0 && view.subviews[targetIndex] == self {
            return
        }
        view.insertSubview(self, at: index)
    }
}

//MARK:- 常量
public extension UIView {
    var ml_estimatedMaxSize : CGSize {
        return CGSize.init(width: self.width, height: CGFloat.greatestFiniteMagnitude)
    }
    func ml_estimatedSize(width: CGFloat) -> CGSize {
        return CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude)
    }
    
    var ml_safeAreaInsets : UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        }else {
            return UIEdgeInsets.init(value: UIApplication.shared.statusBarFrame.maxY, type: .top)
        }
    }
    
    var ml_safeAreaInsetsForIgnoreStatusBar : UIEdgeInsets {
        if #available(iOS 11.0, *) {
            var insets = self.safeAreaInsets
            insets.top = 0
            return insets
        }else {
            return UIEdgeInsets.zero
        }
    }
}
