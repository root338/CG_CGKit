//
//  CGTableViewProtocolBaseManager.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/3/3.
//  Copyright © 2017年 ym. All rights reserved.
//

import UIKit

protocol CGTableViewProxyManagerProtocol : NSObjectProtocol {
    
    /// cell 高度缓存
    var cellHeights : Dictionary<IndexPath, CGFloat> {get set}
    
    /// 注册cell的缓存，用于手动计算IndexPath高度时使用
    var registerCells : Dictionary<String, UITableViewCell> {get set}
    
    /// 加载数据的数组
    var listDataSource : Array<Any> {get set}
    
    
}
