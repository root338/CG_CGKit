//
//  CGLabel.h
//  QuickAskCommunity
//
//  Created by DY on 16/2/26.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CGLabelTextVerticalAlignment) {
    
    CGLabelTextVerticalAlignmentCenter,
    CGLabelTextVerticalAlignmentTop,
    CGLabelTextVerticalAlignmentBottom,
};

@interface CGLabel : UILabel

/** 文本的外间距 */
@property (nonatomic, assign) UIEdgeInsets textMarginEdgeInsets;

/** label文字垂直对齐方式 */
@property (nonatomic, assign) CGLabelTextVerticalAlignment textVerticalAlignment;

@end

NS_ASSUME_NONNULL_END
