//
//  UIView+CGFlowSubviewsSetup.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGFlowSubviewsSetup.h"

#import "CGAddSubviewsCacheModel.h"
#import "CGCreateSubviewsFlowLayoutConfigModel.h"
#import "CGUpdateSubviewsFlowLayoutConfigModel.h"

#import "UIView+Constant.h"

#import "UIView+CGSetupFrame.h"

#import "CGPrintLogHeader.h"

typedef NS_ENUM(NSInteger, CGFlowSubviewsSetupType) {
    
    CGFlowSubviewsSetupTypeCreate,
    CGFlowSubviewsSetupTypeUpdate,
    CGFlowSubviewsSetupTypeInsert,
    CGFlowSubviewsSetupTypeDelete,
};

@implementation UIView (CGFlowSubviewsSetup)

- (CGSize)cg_createFlowViewsWithRule:(__kindof CGCreateSubviewsFlowLayoutConfigModel *)viewsRule createSubviewBlock:(nonnull CGCreateSubviewsBlock)createSubviewBlock setupSubviewSizeBlock:(nullable CGSetupSubviewsSizeBlock)setupSubviewSizeBlock failureBlock:(nullable CGAddSubviewsErrorTypeBlock)failureBlock
{
    return [self cg_flowViewsWithType:CGFlowSubviewsSetupTypeCreate rule:viewsRule createSubviewBlock:createSubviewBlock setupSubviewSizeBlock:setupSubviewSizeBlock failureBlock:failureBlock];
}

- (CGSize)cg_updateFlowViewsWithRule:(__kindof CGUpdateSubviewsFlowLayoutConfigModel *)viewsRule setupSubviewSizeBlock:(CGSetupSubviewsSizeBlock)setupSubviewSizeBlock failureBlock:(CGAddSubviewsErrorTypeBlock)failureBlock
{
    return [self cg_flowViewsWithType:CGFlowSubviewsSetupTypeUpdate rule:viewsRule createSubviewBlock:nil setupSubviewSizeBlock:setupSubviewSizeBlock failureBlock:failureBlock];
}

- (CGSize)cg_flowViewsWithType:(CGFlowSubviewsSetupType)type rule:(__kindof CGBaseSubviewsFlowLayoutConfigModel *)viewsRule createSubviewBlock:(nullable CGCreateSubviewsBlock)createSubviewBlock setupSubviewSizeBlock:(nullable CGSetupSubviewsSizeBlock)setupSubviewSizeBlock failureBlock:(nullable CGAddSubviewsErrorTypeBlock)failureBlock
{
    CGFloat maxWidth;
    CGFloat horizontalSpace = viewsRule.marginEdgeInsets.left + viewsRule.marginEdgeInsets.right;
    if (viewsRule.contentMaxWidth > CGZeroFloatValue) {
        
        maxWidth    = viewsRule.contentMaxWidth - horizontalSpace;
    }else {
        
        maxWidth    = self.width - horizontalSpace;
    }
    
    if (viewsRule.alignmentType == CGAlignmentTypeVertical) {
        if (maxWidth < CGZeroFloatValue) {
            if (failureBlock) {
                failureBlock(CGAddSubviewsErrorTypeViewWidthZero, nil);
            }
            CGDebugAssert(nil, @"垂直铺展子视图时必须设置父视图的宽度");
        }
    }
    CGSize calculateSize    = CGSizeZero;
    
    CGFloat startOriginX    = viewsRule.marginEdgeInsets.left;
    CGPoint origin          = CGPointMake(viewsRule.marginEdgeInsets.left, viewsRule.marginEdgeInsets.top);
    CGFloat maxSubviewsHeight   = 0;
    CGFloat maxSubviewsWidth    = 0;
//    NSInteger startIndex        = 0;
    
//    if (type == CGFlowSubviewsSetupTypeUpdate) {
//        startIndex  = [(CGUpdateSubviewsFlowLayoutConfigModel *)viewsRule startFromIndexUpdate];
//    }
    
    NSMutableArray<CGAddSubviewsCacheModel *> *subviewsCacheModel  = [NSMutableArray array];
    
    for (NSInteger index = 0; index < viewsRule.totalCount; index++) {
        
        UIView *subview = nil;
        
        if (createSubviewBlock) {
            subview = createSubviewBlock(index, nil);
            [self addSubview:subview];
        }
        if (type == CGFlowSubviewsSetupTypeUpdate) {
            subview = [self viewWithTag:index];
            
            if (subview == self) {
                //当子视图是自身时，重新遍历所有子视图
                __block UIView *tempSubview = nil;
                [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.tag == index) {
                        tempSubview = obj;
                        *stop       = YES;
                    }
                }];
                subview = tempSubview;
            }
        }
        
        if (type == CGFlowSubviewsSetupTypeCreate) {
            if ([(CGCreateSubviewsFlowLayoutConfigModel *)viewsRule isAutoSetupIndex]) {
                subview.tag = index;
            }
        }
        
        CGSize sizeForSubview   = CGSizeZero;
        
        if (setupSubviewSizeBlock) {
            sizeForSubview  = setupSubviewSizeBlock(subview, index);
        }else {
            
            BOOL isUseItemSize  = YES;
            if (type == CGFlowSubviewsSetupTypeCreate) {
                
                CGCreateSubviewsFlowLayoutConfigModel *createConfig = viewsRule;
                if (createConfig.isUseCreateViewSize) {
                    
                    isUseItemSize   = NO;
                    sizeForSubview  = subview.size;
                }
            }
            
            if (isUseItemSize) {
                if (!CGSizeEqualToSize(viewsRule.itemSize, CGSizeZero)) {
                    sizeForSubview  = viewsRule.itemSize;
                }
            }
            
            if (CGSizeEqualToSize(CGSizeZero, sizeForSubview)) {
                sizeForSubview  = subview.size;
            }
        }
        
        subview.size  = sizeForSubview;
        
        CGAddSubviewsCacheModel *configCacheModel    = [subviewsCacheModel lastObject];
        if (!configCacheModel) {
            
            configCacheModel        = [[CGAddSubviewsCacheModel alloc] initWithLastOrigin:origin];
            [subviewsCacheModel addObject:configCacheModel];
            configCacheModel.startViewTag   = subview.tag;
        }
        
        if (viewsRule.alignmentType != CGAlignmentTypeHorizontal) {
            //判断 最后坐标 ＋ 宽度 ＋ 视图间间距 是否大于最大宽度
            if (configCacheModel.lastOrigin.x + subview.width + viewsRule.interitemSpacing > maxWidth) {
                //大于时，创建新的配置对象，并设置转行
                CGAddSubviewsCacheModel *newConfigModel = [[CGAddSubviewsCacheModel alloc] initWithLastOrigin:CGPointMake(startOriginX, configCacheModel.lastOrigin.y + configCacheModel.maxSubviewHeight + viewsRule.lineSpacing)];
                
                configCacheModel.endViewTag     = subview.tag - 1;
                newConfigModel.line             = configCacheModel.line + 1;
                configCacheModel                = newConfigModel;
                configCacheModel.startViewTag   = subview.tag;
                [subviewsCacheModel addObject:configCacheModel];
                
                origin  = configCacheModel.lastOrigin;
                
            }
            
            //判断子视图是否大于最大宽度
            if (subview.width > maxWidth) {
                subview.width    = maxWidth;
            }
        }
        
        origin  = configCacheModel.lastOrigin;
        if (configCacheModel.subviews.count) {
            origin.x    += viewsRule.interitemSpacing;
        }
        
        subview.origin              = origin;
        origin.x                    += subview.width;
        configCacheModel.lastOrigin = origin;
        [configCacheModel addView:subview];
        
        configCacheModel.maxSubviewHeight   = MAX(configCacheModel.maxSubviewHeight, subview.height);
        configCacheModel.maxSubviewWidth    = MAX(configCacheModel.maxSubviewWidth, subview.width);
        
        maxSubviewsHeight   = MAX(maxSubviewsHeight, sizeForSubview.height);
        maxSubviewsWidth    = MAX(maxSubviewsWidth, subview.width);
        if (index == viewsRule.totalCount - 1) {
            
            if (viewsRule.alignmentType == CGAlignmentTypeHorizontal) {
                calculateSize   = CGSizeMake(subview.maxX + viewsRule.marginEdgeInsets.right, maxSubviewsHeight + viewsRule.marginEdgeInsets.bottom + viewsRule.marginEdgeInsets.top);
            }else {
                calculateSize   = CGSizeMake(maxSubviewsWidth + viewsRule.marginEdgeInsets.left + viewsRule.marginEdgeInsets.right, subview.maxY + viewsRule.marginEdgeInsets.bottom);
            }
        }
    }
    
    if (viewsRule.subviewsVerticalAlignment != CGViewVerticalAlignmentTop) {
        
        [subviewsCacheModel enumerateObjectsUsingBlock:^(CGAddSubviewsCacheModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CGFloat y = obj.lastOrigin.y;
                
                switch (viewsRule.subviewsVerticalAlignment) {
                    case CGViewVerticalAlignmentBottom:
                        y   += obj.maxSubviewHeight - subview.height;
                        break;
                    case CGViewVerticalAlignmentCenter:
                        y   += (obj.maxSubviewHeight - subview.height)   / 2;
                        break;
                    default:
                        break;
                }
                
                subview.yOrigin = y;
            }];
        }];
    }
    
    return calculateSize;
}

@end
