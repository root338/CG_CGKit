//
//  CGViewAnimationDefineHeader.h
//  QuickAskCommunity
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 ym. All rights reserved.
//

#ifndef CGViewAnimationDefineHeader_h
#define CGViewAnimationDefineHeader_h

NS_ASSUME_NONNULL_BEGIN

/** 动画的类型 */
typedef NS_ENUM(NSInteger, CGViewAnimationStyle) {
    /** 缩放 */
    CGViewAnimationStyleScale,
    CGViewAnimationStyleCustom,
};

typedef NS_ENUM(NSInteger, CGOperateViewAnimationType) {
    /** 缩放 */
    CGOperateViewAnimationTypeShow,
    CGOperateViewAnimationTypeHide,
};

@protocol CGViewCustomAnimationDelegate <NSObject>

@required

- (void)cg_viewWillAnimation;
- (void)cg_viewAnimation;

//@optional

@end

NS_ASSUME_NONNULL_END

#endif /* CGViewAnimationDefineHeader_h */
