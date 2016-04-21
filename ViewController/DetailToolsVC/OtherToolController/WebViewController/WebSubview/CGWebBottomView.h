//
//  CGWebBottomView.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 触发的类型 */
typedef NS_ENUM(NSInteger, CGWebBottomViewActionType) {
    
    /** 未知 */
    CGWebBottomViewActionTypeUnknown,
    /** 回退 */
    CGWebBottomViewActionTypeBack,
    /** 前进 */
    CGWebBottomViewActionTypeForward,
    /** 重新加载 */
    CGWebBottomViewActionTypeReload,
    /** 停止加载 */
    CGWebBottomViewActionTypeStopLoading,
};

@interface CGWebBottomView : UIView

@property (nullable, nonatomic, copy) void (^actionCallback) (CGWebBottomViewActionType actionType);


@end
NS_ASSUME_NONNULL_END