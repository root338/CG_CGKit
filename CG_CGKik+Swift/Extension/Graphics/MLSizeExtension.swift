//
//  MLSizeExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/8/9.
//  Copyright © 2018年 ym. All rights reserved.
//

import Foundation

extension CGSize {
    
    static var maxSize : CGSize {
        return CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    }
    
    func ml_add(insets: UIEdgeInsets) -> CGSize {
        return CGSize.init(width: self.width + (insets.left + insets.right), height: self.height + (insets.top + insets.bottom))
    }
    
    func ml_maxSize(_ maxSize: CGSize) -> CGSize {
        return CGSize.init(width: min(self.width, maxSize.width), height: min(self.height, maxSize.height))
    }
}
