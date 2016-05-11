//
//  CGWebBottomView.m
//  TestCG_CGKit
//
//  Created by DY on 16/4/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWebBottomView.h"

#import "UIButton+CGCreateCustomButton.h"
#import "UIView+CGAddSubview.h"

@interface CGWebBottomView ()
{
    UIButton *_backButton;
    UIButton *_forwardButton;
    UIButton *_reloadButton;
    UIButton *_stopLoading;
}

@end

@implementation CGWebBottomView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    _backButton = [UIButton cg_createButtonWithButtonType:UIButtonTypeSystem normalImage:nil];
    _forwardButton  = [UIButton cg_createButtonWithButtonType:UIButtonTypeSystem normalImage:nil];
    _reloadButton   = [UIButton cg_createButtonWithButtonType:UIButtonTypeSystem normalImage:nil];
    
    [self cg_addSubviews:@[
                           _backButton,
                           _forwardButton,
                           _reloadButton,
                           ]];
}

- (void)cg_setupItemType:(CGWebBottomViewActionType)type enable:(BOOL)enable
{
    UIButton *targetButton  = nil;
    switch (type) {
        case CGWebBottomViewActionTypeBack:
            targetButton    = _backButton;
            break;
        case CGWebBottomViewActionTypeForward:
            targetButton    = _forwardButton;
            break;
        case CGWebBottomViewActionTypeReload:
            targetButton    = _reloadButton;
            break;
        default:
            break;
    }
    
    if (targetButton && targetButton.enabled != enable) {
        [targetButton setEnabled:enable];
    }
}

@end
