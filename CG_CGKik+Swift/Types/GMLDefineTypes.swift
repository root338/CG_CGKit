//
//  GMLDefineTypes.swift
//  QuickAskCommunity
//
//  Created by apple on 2019/12/9.
//  Copyright © 2019 ym. All rights reserved.
//

import Foundation

enum GMLEdgeType {
    case top
    case bottom
    case left
    case right
    
    var reverseEdge : GMLEdgeType {
        switch self {
        case .top: return .bottom
        case .bottom: return .top
        case .left: return .right
        case .right: return .left
        }
    }
}

enum GMLEdgeVerticalType {
    case top
    case center
    case bottom
}

enum GMLEdgeHorizontalType {
    case top
    case center
    case bottom
}

//enum GMLAlignment {
//    case center
//    case top
//    case bottom
//    case left
//    case right
//    case topLeft
//    case topRight
//    case bottomLeft
//    case bottomRight
//}
