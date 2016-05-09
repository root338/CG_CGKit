//
//  CGSearchConstraintTypeHeader.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGSearchConstraintTypeHeader_h
#define CGSearchConstraintTypeHeader_h

/** 搜索到的约束类型 */
typedef NS_ENUM(NSInteger, CGSearchConstraintType) {
    /** 未知，及没有相关约束 */
    CGSearchConstraintTypeUnknown,
    /** 正向，及需要寻找的顺序类型一致 */
    CGSearchConstraintTypeForward,
    /** 反向，及需要寻找的顺序类型相反 */
    CGSearchConstraintTypeReverse,
};

#endif /* CGSearchConstraintTypeHeader_h */
