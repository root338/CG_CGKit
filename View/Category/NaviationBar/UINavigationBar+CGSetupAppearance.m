//
//  UINavigationBar+CGSetupAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 2017/2/23.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "UINavigationBar+CGSetupAppearance.h"
#import <objc/runtime.h>

@interface _CGNavigationBarAppearanceModel : NSObject

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIColor *barTintColor;
@property (nonatomic, strong) UIImage *shadowImage;

@end

@implementation _CGNavigationBarAppearanceModel

@end

@interface UINavigationBar (_CGSetupAppearance)

@property (nonatomic, strong) _CGNavigationBarAppearanceModel *appearanceModel;

@property (nonatomic, assign) BOOL didCacheNavigationBarDefalutType;
@end

@implementation UINavigationBar (_CGSetupAppearance)

- (void)setAppearanceModel:(_CGNavigationBarAppearanceModel *)model
{
    objc_setAssociatedObject(self, @selector(appearanceModel), model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (_CGNavigationBarAppearanceModel *)appearanceModel
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDidCacheNavigationBarDefalutType:(BOOL)isCache
{
    objc_setAssociatedObject(self, @selector(didCacheNavigationBarDefalutType), @(isCache), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)didCacheNavigationBarDefalutType
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end

@implementation UINavigationBar (CGSetupAppearance)

- (void)removeAllCahceNavigationBarAppearanceType
{
    self.navigationBarAppearanceType        = CGNavigationBarAppearanceTypeDefault;
    self.appearanceModel                    = nil;
    self.didCacheNavigationBarDefalutType   = NO;
}

- (void)setNavigationBarAppearanceType:(CGNavigationBarAppearanceType)type
{
    CGNavigationBarAppearanceType appearanceType = self.navigationBarAppearanceType;
    if (type == appearanceType) {
        return;
    }
    
    UIImage *backgroundImage    = nil;
    UIColor *barTintColor       = nil;
    UIImage *shadowImage        = nil;
    
    if (type == CGNavigationBarAppearanceTypeDefault) {
        if (self.didCacheNavigationBarDefalutType == NO) {
            return;
        }
        _CGNavigationBarAppearanceModel *appearanceModel    = self.appearanceModel;
        backgroundImage = appearanceModel.backgroundImage;
        barTintColor    = appearanceModel.barTintColor;
        shadowImage     = appearanceModel.shadowImage;
        
    }else if (type == CGNavigationBarAppearanceTypeClear) {
        
        if (self.didCacheNavigationBarDefalutType == NO) {
            
            _CGNavigationBarAppearanceModel *model = [[_CGNavigationBarAppearanceModel alloc] init];
            model.backgroundImage   = [self backgroundImageForBarMetrics:UIBarMetricsDefault];
            model.barTintColor      = self.barTintColor;
            model.shadowImage       = self.shadowImage;
            
            self.appearanceModel    = model;
            self.didCacheNavigationBarDefalutType   = YES;
        }
        
        backgroundImage = [[UIImage alloc] init];
        barTintColor    = [UIColor clearColor];
        shadowImage     = backgroundImage;
    }
    
    [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [self setBarTintColor:barTintColor];
    [self setShadowImage:shadowImage];
    
    objc_setAssociatedObject(self, @selector(navigationBarAppearanceType), @(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGNavigationBarAppearanceType)navigationBarAppearanceType
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end
