//
//  CGTextView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseTextView.h"

@interface CGTextView : CGBaseTextView

/** 提示文本与文本框之间的边距，默认值(8, 5, 8, 5) */
@property (assign, nonatomic) UIEdgeInsets marginEdgeInsetsForPlaceholderView;

/** 需要显示的提示文本 string is drawn 70% gray */
@property (strong, nonatomic) NSString *placeholder;

/** 富文本提示文本 */
@property (strong, nonatomic) NSAttributedString *attributedPlaceholder;

/** 是否根据提示文本大小改变输入文本框的大小，仅当输入文本框的区域小于提示文本区域时，有约束时无效 */
@property (assign, nonatomic) BOOL adjustsPlaceholderSizeToFitSize;
//@property (strong, nonatomic, readonly) UILabel *placeholderLabel;

/** 调整textView时调用 */
- (void)adjustsTextViewSize:(CGSize)paramSize;
@end
