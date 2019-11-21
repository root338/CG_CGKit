//
// Created by apple on 2018/8/13.
// Copyright (c) 2018 ym. All rights reserved.
//

import Foundation

extension Dictionary where Key : Hashable {
    
    /// 追加 Dictionary 数据
    @discardableResult
    mutating func ml_append(dict: [Key : Value]) -> [Key : Value]? {
        var didAddValue = [Key : Value]()
        for (key, value) in dict {
            if let addValue = self.updateValue(value, forKey: key) {
                didAddValue[key] = addValue
            }
        }
        return didAddValue.count == 0 ? nil : didAddValue
    }
}
