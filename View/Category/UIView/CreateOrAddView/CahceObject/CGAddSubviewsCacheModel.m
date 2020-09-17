//
//  CGAddSubviewsCacheModel.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAddSubviewsCacheModel.h"

@interface CGAddSubviewsCacheModel ()
{
    
}

@property (nonatomic, strong) NSMutableArray<UIView *> *cacheSubviews;

@end

@implementation CGAddSubviewsCacheModel

- (instancetype)initWithLastOrigin:(CGPoint)lastOrigin
{
    self    = [self init];
    if (self) {
        _lastOrigin = lastOrigin;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _line   = 0;
    }
    return self;
}

- (void)addView:(UIView *)view
{
    if (!self.cacheSubviews) {
        self.cacheSubviews  = [NSMutableArray arrayWithObject:view];
    }else {
        [self.cacheSubviews addObject:view];
    }
}

- (nullable UIView *)removeView:(UIView *)view
{
    if ([self.cacheSubviews containsObject:view]) {
        [self.cacheSubviews removeObject:view];
    }else {
        return nil;
    }
    return view;
}

- (nullable UIView *)removeViewAtIndex:(NSInteger)index
{
    if (self.cacheSubviews.count > index) {
        return [self removeView:self.cacheSubviews[index]];
    }
    return nil;
}

- (nullable UIView *)removeViewAtViewTag:(NSInteger)viewTag
{
    __block UIView *view    = nil;
    [self.cacheSubviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == viewTag) {
            view    = obj;
            *stop   = YES;
        }
    }];
    return [self removeView:view];
}

#pragma mark - 设置属性
- (NSMutableArray<UIView *> *)subviews
{
    return self.cacheSubviews;
}

@end
