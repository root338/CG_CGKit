//
//  MLLayerExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2019/8/6.
//  Copyright © 2019 ym. All rights reserved.
//

import Foundation

extension CALayer {
    
    open func ml_set(frame: CGRect, addTo superlayer: CALayer? = nil) {
        if !frame.equalTo(self.frame) {
            self.frame = frame
        }
        if superlayer != nil && self.superlayer != superlayer {
            superlayer!.addSublayer(self)
        }
    }
    
    /// 设置UIView的frame，hidden，当isHidden == true 时，不设置 frame
    open func ml_set(isHidden: Bool, frame: CGRect) {
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
}
