//
//  CGSubviewsTypeHeader.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGSubviewsTypeHeader_h
#define CGSubviewsTypeHeader_h

#import "CGAddSubviewsErrorTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

//创建子视图的block, 参数view表示可复用的view
typedef UIView * _Nonnull (^CGCreateSubviewsBlock) (NSInteger index, UIView * _Nullable view);
//添加子视图的错误
typedef void (^CGAddSubviewsErrorTypeBlock) (CGAddSubviewsErrorType errorType, NSError  * _Nullable error);
//设置子视图的大小
typedef CGSize (^CGSetupSubviewsSizeBlock) (__kindof UIView *view, NSInteger index);

NS_ASSUME_NONNULL_END

#endif /* CGSubviewsTypeHeader_h */
