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
    CGWebViewItemTypeBack,
    /** 前进 */
    CGWebViewItemTypeForward,
    /** 重新加载 */
    CGWebViewItemTypeReload,
    /** 停止加载 */
    CGWebViewItemTypeStopLoading,
    /** 使用UIBarButtonSystemItemFlexibleSpace */
    CGWebViewItemTypeFlexibleSpace,
};

#endif /* CGWebViewToolBarHeader_h */
