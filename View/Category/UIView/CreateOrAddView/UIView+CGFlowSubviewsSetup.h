//
//  UIView+CGFlowSubviewsSetup.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGSubviewsTypeHeader.h"
#import "CGAddSubviewsErrorTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class CGUpdateSubviewsFlowLayoutConfigModel , CGCreateSubviewsFlowLayoutConfigModel;

@interface UIView (CGFlowSubviewsSetup)

/**
 *  创建流类型的子视图
 *
 *  @param viewsRule    创建的规则
 *  @param setupSubview 创建的视图
 *
 *  @return 返回创建子视图所需要的大小
 */
- (CGSize)cg_createFlowViewsWithRule:(__kindof CGCreateSubviewsFlowLayoutConfigModel *)viewsRule createSubviewBlock:(CGCreateSubviewsBlock)createSubviewBlock setupSubviewSizeBlock:(nullable CGSetupSubviewsSizeBlock)setupSubviewSizeBlock failureBlock:(nullable CGAddSubviewsErrorTypeBlock)failureBlock;

/**
 *  更新流类型的子视图布局
 *
 *  @param viewsRule             子视图布局的规则
 *  @param setupSubviewSizeBlock 设置子视图的大小
 *  @param failureBlock          错误回调
 *
 *  @return 返回创建子视图所需要的大小
 */
- (CGSize)cg_updateFlowViewsWithRule:(__kindof CGUpdateSubviewsFlowLayoutConfigModel *)viewsRule setupSubviewSizeBlock:(nullable CGSetupSubviewsSizeBlock)setupSubviewSizeBlock failureBlock:(nullable CGAddSubviewsErrorTypeBlock)failureBlock;


//- (CGSize)cg_insertFlowViewsWithRule:(__kindof CGCreateSubviewsFlowLayoutConfigModel *)viewsRule createSubviewBlock:(CGCreateSubviewsBlock)createSubviewBlock setupSubviewSizeBlock:(nullable CGSetupSubviewsSizeBlock)setupSubviewSizeBlock failureBlock:(nullable CGAddSubviewsErrorTypeBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END