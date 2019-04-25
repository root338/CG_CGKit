//
//  CGControlDefineHeader.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 ym. All rights reserved.
//

import Foundation

public enum CGControlState : Int {
    case normal
    case highlighted
    case disabled
    case selected
    case focused
    case application
    case reserved
    
    public func state() -> UIControl.State {
        
        let state : UIControl.State
        switch self {
        case .normal:
            state   = .normal
        case .highlighted:
            state   = .highlighted
        case .disabled:
            state   = .disabled
        case .selected:
            state   = .selected
        case .focused:
            
            if #available(iOS 9.0, *) {
                state   = .focused
            } else {
                state   = .normal
            }
        case .application:
            state   = .application
        case .reserved:
            state   = .reserved
        }
        return state
    }
}
