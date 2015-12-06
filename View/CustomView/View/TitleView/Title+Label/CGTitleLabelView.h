//
//  CGTitleLabelView.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGTitleBaseView.h"
#import "CGMultilineLabel.h"

/** 标签标题视图 */
@interface CGTitleLabelView : CGTitleBaseView

/** 标题视图 */
@property (strong, nonatomic, readonly) CGMultilineLabel *titleLabel;

/** 
 *  自动根据标题视图内容来计算显示区域 
 *  @warning 当父视图的高度小于计算值时会同步改变父视图的区域
 */
@property (assign, nonatomic) BOOL isAutoUpdateTitleLabelBounds;

/** 更新标题视图的大小 */
- (CGFloat)calcelateTitleViewSize;

/** 当根据子视图来更新父视图时，是否动画更新 */
- (CGFloat)calcelateTitleViewSizeWithAnimated:(BOOL)isAnimated;
@end
