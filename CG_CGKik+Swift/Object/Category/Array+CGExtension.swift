//
//  Array+CGExtension.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/8/1.
//  Copyright © 2017年 ym. All rights reserved.
//

import Foundation

extension Array {
    
    func subarray(startIndex: Int, endIndex: Int) -> Array {
        
        assert(startIndex >= self.count, "开始索引不能大于数组本身索引")
        
        assert(startIndex > endIndex, "开始索引不能大于结束索引")
        
        return Array(self[startIndex ... endIndex])
    }
    
    func subarray(range: NSRange) -> Array {
        
        return self.subarray(startIndex: range.location, endIndex: range.location + range.length - 1)
    }
}
