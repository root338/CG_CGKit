//
//  CGTitleTextView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseView.h"

#import "CGMultilineLabel.h"
#import "CGTextView.h"

/** UILabel + UITextView 的组合视图 */
@interface CGTitleTextView : CGBaseView

@property (assign, nonatomic) UIEdgeInsets  marginEdgeInsets;
@property (assign, nonatomic) CGFloat       spaceSubviews;

@property (strong, nonatomic, readonly) CGMultilineLabel    * titleLabel;
@property (strong, nonatomic, readonly) CGTextView          * textView;

/** 刷新子视图的显示区域，返回子视图最小需要的空间大小 */
- (CGSize)updateSubviewsLayout;
@end
