//
//  CGScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 16/3/10.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGScrollView.h"

@interface CGScrollView ()
{
    /** 开启滑动偏移的标识 */
    BOOL isEnableScrollDirectionMonitorMark;
}
@property (nonatomic, assign, readwrite) CGScrollDirectionType scrollDirectionType;

@end

@implementation CGScrollView

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
    
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    [self setupScrollDirectionMonitorWithWindow:newWindow];
}

- (void)setupScrollDirectionMonitorWithWindow:(UIWindow *)window
{
    if (window) {
        
        if (self.enableScrollDirectionMonitor) {
            if (!isEnableScrollDirectionMonitorMark) {
                
                [self addObserver:self forKeyPath:@"contentOffset" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
                isEnableScrollDirectionMonitorMark = YES;
            }
            
        }
    }else {
        
        if (isEnableScrollDirectionMonitorMark) {
            [self removeObserver:self forKeyPath:@"contentOffset"];
            isEnableScrollDirectionMonitorMark = NO;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGPoint newContentOffset;
        CGPoint oldContentOffset;
        [[change objectForKey:NSKeyValueChangeNewKey] getValue:&newContentOffset];
        [[change objectForKey:NSKeyValueChangeOldKey] getValue:&oldContentOffset];
        
        CGScrollDirectionType horizontalScrollDirectionType;
        CGScrollDirectionType verticalScrollDirectionType;
        if (newContentOffset.x > oldContentOffset.x) {
            horizontalScrollDirectionType   = CGScrollDirectionTypeLeft;
        }else if (newContentOffset.x < oldContentOffset.x) {
            horizontalScrollDirectionType   = CGScrollDirectionTypeRight;
        }else {
            horizontalScrollDirectionType   = CGScrollDirectionTypeStop;
        }
        
        if (newContentOffset.y > oldContentOffset.y) {
            verticalScrollDirectionType = CGScrollDirectionTypeUp;
        }else if (newContentOffset.y < oldContentOffset.y) {
            verticalScrollDirectionType = CGScrollDirectionTypeDown;
        }else {
            verticalScrollDirectionType = CGScrollDirectionTypeStop;
        }
        
        self.scrollDirectionType    = horizontalScrollDirectionType + verticalScrollDirectionType;
        
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 设置属性

- (void)setEnableScrollDirectionMonitor:(BOOL)enableScrollDirectionMonitor
{
    if (_enableScrollDirectionMonitor != enableScrollDirectionMonitor) {
        
        _enableScrollDirectionMonitor = enableScrollDirectionMonitor;
        [self setupScrollDirectionMonitorWithWindow:self.window];
    }
}

- (CGScrollDirectionType)scrollDirectionType
{
    if (!self.enableScrollDirectionMonitor) {
        return CGScrollDirectionTypeUnknown;
    }
    
    return _scrollDirectionType;
}
@end
