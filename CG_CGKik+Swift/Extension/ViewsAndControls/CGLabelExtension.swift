//
//  CGLabelExtension.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/7/28.
//  Copyright © 2017年 ym. All rights reserved.
//

import UIKit

//MARK: - 内容判断扩展
extension UILabel {
    
    /// 查看文本是否为 nil，或空字符串
    var cg_isTextEmpty : Bool {
        var isEmpty = true
        if self.text != nil {
            isEmpty = self.text!.isEmpty
        }
        return isEmpty
    }
}
