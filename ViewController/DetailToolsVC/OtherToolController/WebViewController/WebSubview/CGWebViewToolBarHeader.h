//
//  CGWebViewToolBarHeader.h
//  TestCG_CGKit
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGWebViewToolBarHeader_h
#define CGWebViewToolBarHeader_h

/** 触发的类型 */
typedef NS_ENUM(NSInteger, CGWebViewItemType) {
    
    /** 未知 */
    CGWebViewItemTypeUnknown        = 0,
    /** 回退 */
    CGWebViewItemTypeBack           = 1 << 0,
    /** 前进 */
    CGWebViewItemTypeForward        = 1 << 1,
    /** 重新加载 */
    CGWebViewItemTypeReload         = 1 << 2,
    /** 停止加载 */
    CGWebViewItemTypeStopLoading    = 1 << 3,
};

#endif /* CGWebViewToolBarHeader_h */
