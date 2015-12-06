//
//  CGTitleTextView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseView.h"

#import "CGMultilineLabel.h"
#import "CGInputTextView.h"

/** UILabel + UITextView 的组合视图 */
@interface CGTitleTextView : CGBaseView

@property (assign, nonatomic) UIEdgeInsets  marginEdgeInsets;
@property (assign, nonatomic) CGFloat       spaceSubviews;

@property (strong, nonatomic, readonly) CGMultilineLabel    * titleLabel;
@property (strong, nonatomic, readonly) CGInputTextView     * textView;

@property (strong, nonatomic) UIColor *textViewEditBackgroundColor;
@property (strong, nonatomic) UIColor *textViewNormalBackgroundColor;

@property (assign, nonatomic) CGFloat textViewMinHeight;

/** 关闭自动设置子视图显示区域 */
@property (assign, nonatomic) BOOL disableAutoSetupSubviewsFrame;

/** 
 *  刷新子视图的显示区域，返回子视图最小需要的空间大小
 *  @warning默认会自动设置子视图显示区域，用disableAutoSetupSubviewsFrame设置来关闭自动设置
 */
- (CGFloat)updateSubviewsLayout;
@end
