//
//  CGRectExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 ym. All rights reserved.
//

import Foundation

extension CGRect {
    
    func ml_centerRect(size: CGSize) -> CGRect {
        return CGRect.init(x: (self.size.width - size.width) / 2, y: (self.size.height - size.height) / 2, width: size.width, height: size.height)
    }
}
