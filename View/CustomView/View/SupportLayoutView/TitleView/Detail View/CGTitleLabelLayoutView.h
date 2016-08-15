//
//  CGTitleLabelLayoutView.h
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGLayoutMarginBaseView.h"
#import "CGMultilineLabel.h"

NS_ASSUME_NONNULL_BEGIN
/** 带约束的标签标题  */
@interface CGTitleLabelLayoutView : CGLayoutMarginBaseView

@property (nonatomic, strong, readonly) CGMultilineLabel *titleLabel;

- (instancetype)initWithMarginEdgeInstes:(UIEdgeInsets)marginEdgeInstes;

@end
NS_ASSUME_NONNULL_END