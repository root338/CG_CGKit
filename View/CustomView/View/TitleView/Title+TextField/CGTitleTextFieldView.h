//
//  CGTitleTextField.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGTitleBaseView.h"

#import "CGBaseLabel.h"
#import "CGBaseTextField.h"
#import "CGAlignmentHeader.h"

/** 带标题的表格视图 */
@interface CGTitleTextFieldView : CGTitleBaseView

#pragma mark - 标题的设置

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSAttributedString *attributedTitle;

#pragma mark - 标题样式设置
/** 相对于文本框，标题所在的位置，默认 CGViewPositionStyleLeft */
@property (assign, nonatomic) CGViewPositionStyle positionStyle;

/** 标题视图与文本框之间的间距 */
@property (assign, nonatomic) CGFloat spaceSubviews;
#pragma mark - 
/** 输入文本框 */
@property (strong, nonatomic, readonly) CGBaseTextField *textField;

/** 标题视图 */
@property (strong, nonatomic, readonly) CGBaseLabel *titleLabel;


@end
