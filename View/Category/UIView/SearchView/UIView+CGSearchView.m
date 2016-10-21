//
//  UIView+CGSearchView.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/28.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIView+CGSearchView.h"

#import "UIView+CGSetupFrame.h"

#import "CGPrintLogHeader.h"

#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, CGSearchInputViewType) {
    
    CGSearchInputViewTypePrevious,
    CGSearchInputViewTypeNext,
};

@implementation UIView (CGSearchView)

- (id)searchSuperViewWithClass:(Class)className
{
    if (!self.superview) {
        return nil;
    }
    
    if ([self.superview isKindOfClass:className]) {
        return self.superview;
    }else {
        return [self.superview searchSuperViewWithClass:className];
    }
}

- (__kindof UIView *)cg_searchCommonSuperviewWithView:(__kindof UIView *)otherView
{
    UIView *paramSuperview  = nil;
    UIView *startView       = self;
    
    while (!paramSuperview && startView) {
        
        if ([otherView isDescendantOfView:startView]) {
            paramSuperview  = startView;
        }
        startView   = startView.superview;
    }
    return paramSuperview;
}

- (nullable __kindof UIViewController *)cg_searchViewControllerOfLate
{
    return [self cg_searchViewControllerWithClass:[UIViewController class]];
}

- (nullable __kindof UIViewController *)cg_searchViewControllerWithClass:(Class)className
{
    UIResponder *responder  = [self nextResponder];
    while (responder && ![responder isKindOfClass:[className class]]) {
        responder   = [responder nextResponder];
    }
    return (UIViewController *)responder;
}

+ (nullable __kindof UIView *)cg_searchFirstResponder
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    return [window cg_searchFirstResponder];
}

- (nullable __kindof UIView *)cg_searchFirstResponder
{
    UIView *firstResponder  = nil;
    
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *obj in self.subviews) {
        
        firstResponder  = [obj cg_searchFirstResponder];
        if (firstResponder) {
            return firstResponder;
        }
    }
    
    return nil;
}

@end

@implementation UIView (CGSearchNextInputView)

+ (UIView *)searchNextWithCurrentInputView:(UIView *)currentInputView
{
    UIWindow *window    = [[UIApplication sharedApplication].delegate window];
    return [window searchNextWithCurrentInputView:currentInputView];
}

+ (UIView *)searchPreviousWithCurrentInputView:(UIView *)currentInputView
{
    UIWindow *window    = [[UIApplication sharedApplication].delegate window];
    return [window searchPreviousWithCurrentInputView:currentInputView];
}

- (UIView *)searchNextWithCurrentInputView:(UIView *)currentInputView
{
    return [self searchType:CGSearchInputViewTypeNext currentView:currentInputView];
}

- (UIView *)searchPreviousWithCurrentInputView:(UIView *)currentInputView
{
    return [self searchType:CGSearchInputViewTypePrevious currentView:currentInputView];
}

- (UIView *)searchInputTextControl
{
    NSArray *inputControls = [self searchSubviewsInputViewsWithExcludeView:nil isOnlyOne:YES];
    return inputControls.firstObject;
}

/** 执行搜索的类型，进行搜索 */
- (UIView *)searchType:(CGSearchInputViewType)type currentView:(UIView *)currentInputView;
{
    if (!currentInputView.superview) {
        CGErrorLog(@"没有父视图<_<");
        return nil;
    }
    
    NSArray<UIView *> *inputViews = self.cacheInputViews;
    
    if (!inputViews) {
        
        if (self.isCacheInputViews) {
            //
            self.cacheInputViews = [self searchSubviewsInputViews];
            inputViews = self.cacheInputViews;
        }else {
            inputViews = [self searchSubviewsInputViewsWithExcludeView:currentInputView];
        }
    }
    
    //当前视图的坐标到本视图中的位置
    CGPoint positionForCurrentView = [currentInputView.superview convertPoint:currentInputView.origin toView:self];
    
    //目标输入视图
    __block UIView  *   targetInputView     = nil;
    __block CGPoint     targetInputPostion  = CGPointZero;
    
    [inputViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj != currentInputView) {
            
            //其他视图坐标
            CGPoint otherViewPostion = [obj.superview convertPoint:obj.origin toView:self];
            
            //当前输入视图与对比输入视图y坐标相等时
            BOOL equalConditionCurrentView = NO;
            if (otherViewPostion.y == positionForCurrentView.y) {
                if (type == CGSearchInputViewTypeNext) {
                    //下一视图（只有当 目标视图(xOrigin) > 当前输入视图(xOrigin)时条件满足）
                    equalConditionCurrentView = (otherViewPostion.x > positionForCurrentView.x);
                }else {
                    //上一视图（只有当  目标视图(xOrigin) < 当前输入视图(xOrigin) 时条件满足）
                    equalConditionCurrentView = (otherViewPostion.x < positionForCurrentView.x);
                }
            }
            
            //当前输入视图与对比输入视图y坐标不等时
            BOOL unequalConditionCurrentView= NO;
            if (type == CGSearchInputViewTypeNext) {
                unequalConditionCurrentView = (otherViewPostion.y > positionForCurrentView.y);
            }else {
                unequalConditionCurrentView = (otherViewPostion.y < positionForCurrentView.y);
            }
            
            if (unequalConditionCurrentView || equalConditionCurrentView) {
                if (targetInputView) {
                    //当存在目标视图时
                    
                    //当两个输入框（!!都非当前输入视图）y坐标一样时
                    BOOL equalCondition = NO;
                    if (targetInputPostion.y == otherViewPostion.y) {
                        if (type == CGSearchInputViewTypeNext) {
                            //下一视图（两个对比视图，只有 x 坐标 更小 的那个满足条件）
                            equalCondition = (targetInputPostion.x > otherViewPostion.x);
                        }else {
                            //上一视图（两个对比视图，只有 x 坐标 更大 的那个满足条件）
                            equalCondition = (targetInputPostion.x < otherViewPostion.x);
                        }
                    }
                    
                    BOOL unequalCondition = NO;
                    if (type == CGSearchInputViewTypeNext) {
                        unequalCondition = targetInputPostion.y > otherViewPostion.y;
                    }else {
                        unequalCondition = targetInputPostion.y < otherViewPostion.y;
                    }
                    
                    if (unequalCondition || equalCondition) {
                        //当目标视图比现比较视图y坐标高时替换
                        targetInputView     = obj;
                        targetInputPostion  = otherViewPostion;
                    }
                }else {
                    //当不存在目标视图时直接赋值
                    targetInputView     = obj;
                    targetInputPostion  = otherViewPostion;
                }
            }
        }
    }];
    
    return targetInputView;
}

- (NSArray *)searchSubviewsInputViews
{
    return [self searchSubviewsInputViewsWithExcludeView:nil];
}

- (NSArray *)searchSubviewsInputViewsWithExcludeView:(UIView *)excludeView
{
    return [self searchSubviewsInputViewsWithExcludeView:excludeView isOnlyOne:NO];
}

- (NSArray *)searchSubviewsInputViewsWithExcludeView:(UIView *)excludeView isOnlyOne:(BOOL)isOnlyOne
{
    return [self searchSubviewsInputViewsWithExcludeView:excludeView isOnlyOne:isOnlyOne targetViewClassArray:[self inputViewClasses]];
}

- (NSArray *)searchSubviewsInputViewsWithExcludeView:(UIView *)excludeView isOnlyOne:(BOOL)isOnlyOne targetViewClassArray:(NSArray<Class> *)targetViewClassArray
{
    if (!([self isKindOfClass:[UIView class]])) {
        return nil;
    }
    
    //视图不包含指定视图
    if (self == excludeView) {
        return nil;
    }
    
    if ([targetViewClassArray containsObject:self.class]) {
        //当视图本身就属于输入视图时返回自身
        return @[self];
    }
    
    if (!(self.subviews.count)) {
        return nil;
    }
    
    __block NSMutableArray *inputsViews = nil;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj != excludeView) {
            //子视图不等于excludeView
            
            id targetObj = nil;
            if ([targetViewClassArray containsObject:obj.class]) {
                //检验视图属于输入视图的类
                targetObj = obj;
            }else  if (obj.subviews.count) {
                
                //子视图不属于输入视图，但有子视图
                targetObj = [obj searchSubviewsInputViews];
            }
            
            if (targetObj) {
                
                if (!inputsViews) {
                    //当存储数组为空时
                    inputsViews = [NSMutableArray array];
                }
                if ([targetObj isKindOfClass:[NSArray class]]) {
                    //符合视图属于数组
                    [inputsViews addObjectsFromArray:targetObj];
                }else {
                    //否则属于单个输入视图
                    [inputsViews addObject:targetObj];
                }
                
                if (isOnlyOne) {
                    *stop = YES;
                }
            }
        }
    }];
    
    return inputsViews;
}

/** 输入视图可能属于哪个类 */
- (NSArray<Class> *)inputViewClasses
{
    return @[
             [UITextField class],
             [UITextView class],
             ];
}

#pragma mark - 设置属性
- (NSArray<UIView *> *)cacheInputViews
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCacheInputViews:(NSArray<UIView *> *)cacheViews
{
    objc_setAssociatedObject(self, @selector(cacheInputViews), cacheViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isCacheInputViews
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsCacheInputViews:(BOOL)isCache
{
    objc_setAssociatedObject(self, @selector(isCacheInputViews), @(isCache), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
