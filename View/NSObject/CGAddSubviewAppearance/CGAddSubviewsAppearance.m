//
//  CGAddSubviewsAppearance.m
//  TestCG_CGKit
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAddSubviewsAppearance.h"

#import "UIView+CGSetupFrame.h"

#import "CGPrintLogHeader.h"

typedef NS_ENUM(NSInteger, _CGAddSubviewsAppearanceType){
    
    _CGAddSubviewsAppearanceTypeWidth,
    _CGAddSubviewsAppearanceTypeHeight,
};

@implementation CGAddSubviewsAppearance

- (void)initialization
{
    _marginEdgeInset    = UIEdgeInsetsZero;
    _horizontalSpace    = 0;
    _verticalSpace      = 0;
    _itemWidth          = 0;
    _itemHeight         = 0;
}

- (void)cg_getWidthWithSuperview:(__kindof UIView *)paramSuperview completion:(void (^)(CGAddSubviewsErrorType, CGFloat, CGFloat))completion
{
    [self cg_judgeLengthWithSuperview:paramSuperview type:_CGAddSubviewsAppearanceTypeWidth completion:completion];
}

- (void)cg_getHeightWithSuperview:(__kindof UIView *)paramSuperview completion:(void (^)(CGAddSubviewsErrorType, CGFloat, CGFloat))completion
{
    [self cg_judgeLengthWithSuperview:paramSuperview type:_CGAddSubviewsAppearanceTypeHeight completion:completion];
}

- (BOOL)cg_judgeShouldCreateSubviewsWithSuperview:(__kindof UIView *)paramSuperview
{
    CGAddSubviewsErrorType errorType   = CGAddSubviewsErrorTypeNone;
    
    
    if (self.shouldPrivatePropertyValue) {
        //必要条件满足
        
        //检查宽度
        errorType   = [self cg_judgeLengthWithSuperview:paramSuperview type:_CGAddSubviewsAppearanceTypeWidth completion:nil];
        
        if (errorType != CGAddSubviewsErrorTypeNone) {
            return errorType;
        }
        
        //检查高度
        errorType   = [self cg_judgeLengthWithSuperview:paramSuperview type:_CGAddSubviewsAppearanceTypeHeight completion:nil];
        if (errorType != CGAddSubviewsErrorTypeNone) {
            return errorType;
        }
        
    }else {
        
        errorType   = CGAddSubviewsErrorTypePrivate;
    }
    
    return errorType;
}

- (CGAddSubviewsErrorType)cg_judgeLengthWithSuperview:(UIView *)paramSuperview type:(_CGAddSubviewsAppearanceType)appearanceType completion:(void  (^ _Nullable ) (CGAddSubviewsErrorType errorType, CGFloat targetLength, CGFloat paramSuperTargetLength))completion
{
    /** 默认的表示0值 */
    CGFloat zeroValue  = 0.001;
    
    CGAddSubviewsErrorType  errorType   = CGAddSubviewsErrorTypeNone;
    BOOL    isAutoSetupViewTargetLength;
    CGFloat itemTargetLength, paramSuperviewTargetLength;
    CGFloat marginTotalSpace, subviewsTotalSpace;
    NSInteger tempCount;
    
    CGFloat targetLength, paramSuperTargetLength;
    
    if (appearanceType == _CGAddSubviewsAppearanceTypeWidth) {
        
        isAutoSetupViewTargetLength = self.isAutoSetupViewWidth;
        itemTargetLength            = self.itemWidth;
        paramSuperviewTargetLength  = paramSuperview.width;
        tempCount                   = self.count;
        
        marginTotalSpace            = self.marginEdgeInset.left + self.marginEdgeInset.right;
        subviewsTotalSpace          = (tempCount - 1) * self.horizontalSpace;
        
    }else {
        
        isAutoSetupViewTargetLength = self.isAutoSetupViewHeight;
        itemTargetLength            = self.itemHeight;
        paramSuperviewTargetLength  = paramSuperview.height;
        tempCount                   = ceil(self.subviewsTotal / self.count);
        
        marginTotalSpace            = self.marginEdgeInset.top + self.marginEdgeInset.bottom;
        subviewsTotalSpace          = (tempCount - 1) * self.verticalSpace;
        
    }
    
    //检查父视图的指定长度是否可以计算
    if (isAutoSetupViewTargetLength) {
        //可以自动设置视图时
        //其必要条件，itemTargetLength 已知
        
        if (itemTargetLength <= zeroValue) {
            
            if (appearanceType == _CGAddSubviewsAppearanceTypeHeight) {
                errorType   = CGAddSubviewsErrorTypeUnknownViewHeight;
            }else if (appearanceType == _CGAddSubviewsAppearanceTypeWidth) {
                errorType   = CGAddSubviewsErrorTypeUnknownViewWidth;
            }
        }else {
            //自动推导目标长度
            paramSuperviewTargetLength  = marginTotalSpace + subviewsTotalSpace + itemTargetLength * tempCount;
        }
    }else {
        //不自动设置视图指定长度时
        //必要条件:   视图指定长度不为0
        //           如果设置 itemTargetLength 设置应该符合视图的布局要求
        
        if (paramSuperviewTargetLength <= zeroValue) {
            
            if (appearanceType == _CGAddSubviewsAppearanceTypeHeight) {
                errorType   = CGAddSubviewsErrorTypeViewHeightZero;
            }else if (appearanceType == _CGAddSubviewsAppearanceTypeWidth) {
                errorType   = CGAddSubviewsErrorTypeViewWidthZero;
            }
        }else  {
            
            if (itemTargetLength > zeroValue) {
                //当子视图的指定长度已设置时且视图相应长度不自动设置时，判断已设置的视图指定长度是否符合预期宽度
                CGFloat tempViewlength   = marginTotalSpace + subviewsTotalSpace + itemTargetLength * tempCount;
                CGFloat differenceValue = tempViewlength - paramSuperviewTargetLength;
                if (differenceValue > zeroValue || differenceValue < -zeroValue) {
                    //指定值超出偏差值之外
                    errorType   = CGAddSubviewsErrorTypeWidthNotCompatible;
                    if (appearanceType == _CGAddSubviewsAppearanceTypeHeight) {
                        errorType   = CGAddSubviewsErrorTypeHeightNotCompatible;
                    }else if (appearanceType == _CGAddSubviewsAppearanceTypeWidth) {
                        errorType   = CGAddSubviewsErrorTypeWidthNotCompatible;
                    }
                }
            }else {
                //自动推导目标子视图长度
                itemTargetLength    = (paramSuperviewTargetLength - marginTotalSpace - subviewsTotalSpace) / (CGFloat)tempCount;
            }
        }
    }
    
    targetLength            = itemTargetLength;
    paramSuperTargetLength  = marginTotalSpace + subviewsTotalSpace + itemTargetLength * tempCount;
    
    if (errorType != CGAddSubviewsErrorTypeNone) {
        targetLength            = 0;
        paramSuperTargetLength  = 0;
    }
    if (completion) {
        completion(errorType, targetLength, paramSuperTargetLength);
    }
    return errorType;
}

#pragma mark - 只读判断属性
- (BOOL)shouldPrivatePropertyValue
{
    BOOL isResult   = NO;
    CGErrorConditionLog(self.subviewsTotal == 0, @"需要添加的子视图数量不能为0");
    CGErrorConditionLog(self.count == 0, @"横向添加的子视图数不能为0");
    isResult    = self.subviewsTotal && self.count;
    return isResult;
}
@end
