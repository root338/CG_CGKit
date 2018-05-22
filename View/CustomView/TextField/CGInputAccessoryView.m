//
//  CGTextFieldInputView.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/23.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGInputAccessoryView.h"

#import "UIView+CGSearchView.h"
#import "CGAngleRadianHeader.h"
#import "UIView+CGAddSubview.h"
#import "UIView+CGAddConstraints.h"
#import "NSArray+CGAddConstraints.h"
#import "UIButton+CGSetupAppearance.h"
#import "UIButton+CGCreateCustomButton.h"

#import "CGArrowIconConfig.h"
#import "UIImage+CGDrawIcon.h"

#import "CGInputAccessoryViewAppearance.h"

@interface CGInputAccessoryView ()
{
    
}

@property (nonatomic, strong, readwrite) UIButton *leftArrowButton;
@property (nonatomic, strong, readwrite) UIButton *rightArrowButton;
@property (nonatomic, strong, readwrite) UIButton *finishButton;

@end



@implementation CGInputAccessoryView

+ (instancetype)defaultInputAccessoryView
{
    return [[self alloc] initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame appearance:[CGInputAccessoryViewAppearance defalutAppearance]];
}

- (instancetype)initWithFrame:(CGRect)frame appearance:(CGInputAccessoryViewAppearance *)appearance
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _appearance                     = appearance;
        _enableAutoChangeArrowStatus    = YES;
        [self setupContentView];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupContentView];
}

- (void)setupContentView
{
    if (_appearance == nil) {
        _appearance = [CGInputAccessoryViewAppearance defalutAppearance];
    }
    CGArrowIconConfig *config   = [CGArrowIconConfig defaultArrowConfig];
    config.size                 = _appearance.arrowSize;
    config.angle                = 90;
    config.lineWidth            = _appearance.arrowLineWidth;
    config.tintColor            = _appearance.arrowImageTintColor;
    
    UIImage *normalArrowImage   = [UIImage drawArrowWithConfig:config];
    
    _leftArrowButton    = [UIButton cg_createButtonWithButtonType:UIButtonTypeSystem normalImage:normalArrowImage];
    
    _rightArrowButton   = [UIButton cg_createButtonWithButtonType:UIButtonTypeSystem normalImage:normalArrowImage];
    _rightArrowButton.imageView.transform   = CGAffineTransformMakeRotation(_CG_RadianForAngle(180));
    _finishButton       = [UIButton cg_createButtonWithButtonType:UIButtonTypeSystem title:_appearance.finishTitle titleColor:nil font:_appearance.titleFont];
    [_finishButton cg_setupTitleColors:_appearance.titleColors];
    
    [_leftArrowButton addTarget:self action:@selector(handleClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightArrowButton addTarget:self action:@selector(handleClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_finishButton addTarget:self action:@selector(handleClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *subviews   = @[
                            _leftArrowButton,
                            _rightArrowButton,
                            _finishButton
                            ];
    
    [self cg_addSubviews:subviews];
    
    CGFloat verticalSpace       = 1;
    CGFloat horizontalSpace     = 8;
    subviews.subviewsSpaceValue = horizontalSpace;
    
    [subviews cg_autoSetupHorizontalSubviewsLayoutAxisHorizontalWithMarginInsets:UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace) setupSubviewsSpace:nil setupSubviewsLayoutRelation:^NSLayoutRelation(UIView * _Nonnull view1, CGLayoutEdge view1LayoutEdge, UIView * _Nonnull view2, CGLayoutEdge view2LayoutEdge) {
        NSLayoutRelation relation = NSLayoutRelationEqual;
        if (view1 == self->_rightArrowButton && view2 == self->_finishButton) {
            relation    = NSLayoutRelationGreaterThanOrEqual;
        }
        return relation;
    } setupSubviewLayoutRelation:nil];
    
    self.backgroundColor    = _appearance.backgroundColor;
    
}

- (void)handleClickAction:(id)sender
{
    CGInputAccessoryViewButtonType  type    = 0;
    
    if (sender == _leftArrowButton) {
        
        type    = CGInputAccessoryViewButtonTypeLeftArrow;
    }else if (sender == _rightArrowButton) {
        
        type    = CGInputAccessoryViewButtonTypeRightArrow;
    }else if (sender == _finishButton) {
        
        type    = CGInputAccessoryViewButtonTypeCarryOut;
    }
    
    if ([self.delegate respondsToSelector:@selector(inputAccessoryView:buttonType:)]) {
        [self.delegate inputAccessoryView:self
                               buttonType:type];
    }
    if (self.didClickCallback) {
        
        self.didClickCallback(type, sender);
    }
        
    if (type == CGInputAccessoryViewButtonTypeLeftArrow || type == CGInputAccessoryViewButtonTypeRightArrow) {
        
        [self setupArrowStatusWithButtonType:type];
        
    }else if (type == CGInputAccessoryViewButtonTypeCarryOut) {
        
        BOOL canResignFirstResponder    = !self.disableChangeFirstResponder;
        if (canResignFirstResponder) {
            UIView *currentFirstResponder   = [self searchCurrentFirstResponder];
            
            if (currentFirstResponder && [currentFirstResponder canResignFirstResponder]) {
                if ([self.delegate respondsToSelector:@selector(inputAccessoryView:canResignFirstResponderWithView:actionButtonType:)]) {
                    canResignFirstResponder = [self.delegate inputAccessoryView:self canResignFirstResponderWithView:currentFirstResponder actionButtonType:type];
                }
                
                if (canResignFirstResponder) {
                    [currentFirstResponder resignFirstResponder];
                }
            }
        }
    }
}

- (void)setupArrowStatusWithButtonType:(CGInputAccessoryViewButtonType)type
{
    if (!self.enableAutoChangeArrowStatus) {
        return;
    }
    
    __block UIView *previousInputView   = nil;
    __block UIView *nextInputView       = nil;
    
    BOOL enableSearchPreviousView, enableSearchNextView;
    
    if (type == CGInputAccessoryViewButtonTypeLeftArrow) {
        enableSearchPreviousView    = YES;
        enableSearchNextView        = NO;
    }else if (type == CGInputAccessoryViewButtonTypeRightArrow) {
        enableSearchPreviousView    = NO;
        enableSearchNextView        = YES;
    }else {
        enableSearchPreviousView    = YES;
        enableSearchNextView        = YES;
    }
    
    [self searchContextInputViewWithEnableSearchPreviousView:enableSearchPreviousView enableSearchNextView:enableSearchNextView setupFirstResponderBlock:nil completion:^(UIView *previousView, UIView *nextView) {
        previousInputView   = previousView;
        nextInputView       = nextView;
    }];
    //搜索即将要成为第一响应者的视图
    [self searchContextInputViewCompletion:^(UIView *previousView, UIView *nextView) {
        previousInputView   = previousView;
        nextInputView       = nextView;
    }];
    
    if (type == CGInputAccessoryViewButtonTypeLeftArrow || type == CGInputAccessoryViewButtonTypeRightArrow) {
        
        BOOL canChangeFirstResponder    = !self.disableChangeFirstResponder;
        UIView *willFirstResponderView  = nil;
        
        if (type == CGInputAccessoryViewButtonTypeLeftArrow) {
            willFirstResponderView  = previousInputView;
        }else if (type == CGInputAccessoryViewButtonTypeRightArrow) {
            willFirstResponderView  = nextInputView;
        }
        
        if (willFirstResponderView && [willFirstResponderView canBecomeFirstResponder]) {
            
            if ([self.delegate respondsToSelector:@selector(inputAccessoryView:canBecomeFirstResponderWithView:actionButtonType:)]) {
                canChangeFirstResponder = [self.delegate inputAccessoryView:self canBecomeFirstResponderWithView:willFirstResponderView actionButtonType:type];
            }
            if (canChangeFirstResponder) {
                
                [willFirstResponderView becomeFirstResponder];
                //当改变第一响应者时，改变上一视图和下一视图的内容
                [self searchContextInputViewWithEnableSearchPreviousView:YES enableSearchNextView:YES setupFirstResponderBlock:^UIView *{
                    return willFirstResponderView;
                } completion:^(UIView *previousView, UIView *nextView) {
                    previousInputView   = previousView;
                    nextInputView       = nextView;
                }];
            }
        }
    }
    
    self.leftArrowButton.enabled    = previousInputView != nil;
    self.rightArrowButton.enabled   = nextInputView     != nil;
}

/** 搜索第一响应者 */
- (UIView *)searchCurrentFirstResponder
{
    UIView *currentFirstResponder       = nil;
    if ([self.delegate respondsToSelector:@selector(currentFirstResponderInputAccessoryView:)]) {
        currentFirstResponder   = [self.delegate currentFirstResponderInputAccessoryView:self];
    }else {
        currentFirstResponder   = [UIView cg_searchFirstResponder];
    }
    return currentFirstResponder;
}

- (void)searchContextInputViewCompletion:(void (^) (UIView *previousView, UIView *nextView))completion
{
    [self searchContextInputViewWithEnableSearchPreviousView:YES enableSearchNextView:YES setupFirstResponderBlock:nil completion:completion];
}

/**
 搜索上下关联的输入框

 @param enableSearchPreviousView   是否搜索上一个输入框
 @param enableSearchNextView       是否搜索下一个输入框
 @param completion                 返回结果
 */
- (void)searchContextInputViewWithEnableSearchPreviousView:(BOOL)enableSearchPreviousView enableSearchNextView:(BOOL)enableSearchNextView setupFirstResponderBlock:(UIView * (^)(void))setupFirstResponderBlock completion:(void (^) (UIView *previousView, UIView *nextView))completion
{
    if (!enableSearchPreviousView && !enableSearchNextView) {
        return;
    }
    
    __block UIView *previousInputView   = nil;
    __block UIView *nextInputView       = nil;
    
    BOOL enableAutoSearchPreviousView   = enableSearchPreviousView;
    BOOL enableAutoSearchNextView       = enableSearchNextView;
    
    if (enableSearchPreviousView) {
        if ([self.delegate respondsToSelector:@selector(previousViewInputAccessoryView:)]) {
            previousInputView   = [self.delegate previousViewInputAccessoryView:self];
            enableAutoSearchPreviousView    = NO;
        }
    }
    if (enableSearchNextView) {
        if ([self.delegate respondsToSelector:@selector(nextViewInputAccessoryView:)]) {
            nextInputView   = [self.delegate nextViewInputAccessoryView:self];
            enableAutoSearchNextView    = NO;
        }
    }
    
    if (!(!enableAutoSearchPreviousView && !enableAutoSearchNextView)) {
        
        UIView *firstResponderView   = nil;
        if (setupFirstResponderBlock) {
            firstResponderView  = setupFirstResponderBlock();
        }else {
            firstResponderView  = [self searchCurrentFirstResponder];
        }
        
        if (firstResponderView) {
            //当存在第一响应者时搜索是否存在上一个输入框，下一个输入框
            NSSet<UIView *> *rangeViews = nil;
            if ([self.delegate respondsToSelector:@selector(searchInputRangeViewsInputAccessoryView:)]) {
                rangeViews  = [self.delegate searchInputRangeViewsInputAccessoryView:self];
            }else {
                rangeViews  = self.rangeViews;
            }
            
            if (rangeViews) {
                
                [rangeViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if (previousInputView == nil && enableAutoSearchPreviousView) {
                        previousInputView   = [obj searchPreviousWithCurrentInputView:firstResponderView];
                    }
                    if (nextInputView == nil && enableAutoSearchNextView) {
                        nextInputView   = [obj searchNextWithCurrentInputView:firstResponderView];
                    }
                    if (previousInputView != nil && nextInputView != nil) {
                        *stop   = YES;
                    }
                }];
            }else {
                
                if (enableAutoSearchPreviousView) {
                    previousInputView   = [UIView searchPreviousWithCurrentInputView:firstResponderView];
                }
                if (enableAutoSearchNextView) {
                    nextInputView       = [UIView searchNextWithCurrentInputView:firstResponderView];
                }
            }
        }
    }
    
    if (completion) {
        completion(previousInputView, nextInputView);
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        [self setupArrowStatusWithButtonType:0];
    }
}


@end
