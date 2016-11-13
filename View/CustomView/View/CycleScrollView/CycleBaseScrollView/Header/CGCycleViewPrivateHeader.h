//
//  CGCycleViewPrivateHeader.h
//  TestProject
//
//  Created by DY on 15/11/26.
//  Copyright © 2015年 -. All rights reserved.
//

#ifndef CGCycleViewPrivateHeader_h
#define CGCycleViewPrivateHeader_h

/**
 *  子视图的类型
 */
typedef NS_ENUM(NSInteger, _CGCycleSubviewType) {
    
    /**
     *  上一视图
     */
    _CGCycleSubviewTypePreviousIndex    = -1,
    /**
     *  当前视图
     */
    _CGCycleSubviewTypeCurrentIndex,
    /**
     *  下一视图
     */
    _CGCycleSubviewTypeNextIndex,
};

#endif /* CGCycleViewPrivateHeader_h */
