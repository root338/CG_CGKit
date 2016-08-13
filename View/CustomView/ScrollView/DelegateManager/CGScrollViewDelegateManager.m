//
//  CGScrollViewDelegateManager.m
//  TestCG_CGKit
//
//  Created by DY on 16/8/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGScrollViewDelegateManager.h"

#import "CGScrollView.h"

@interface CGScrollViewDelegateManager ()
{
    CGPoint _startPoint;
    CGPoint _endPoint;
}

@property (nonatomic, assign, readwrite) CGScrollControlType scrollControlType;
@property (nonatomic, assign, readwrite) CGScrollDirectionType scrollDirectionType;

@property (nonatomic, assign, readwrite) CGFloat verticalMeanVelocity;
@property (nonatomic, assign, readwrite) CGFloat horizontalMeanVelocity;

@end

@implementation CGScrollViewDelegateManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupInitialPoint:CGPointZero];
    }
    return self;
}

- (void)setupInitialPoint:(CGPoint)initialPoint
{
    _startPoint = initialPoint;
    _endPoint   = initialPoint;
}

- (void)clearMeanVelocity
{
    self.verticalMeanVelocity   = 0;
    self.horizontalMeanVelocity = 0;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(CGScrollView *)scrollView
{
    _endPoint   = scrollView.contentOffset;
    
    CGScrollDirectionType verticalDirectionType;
    CGScrollDirectionType horizontalDirectionType;
    if (_endPoint.x > _startPoint.x) {
        horizontalDirectionType = CGScrollDirectionTypeLeft;
    }else if (_endPoint.x < _startPoint.x) {
        horizontalDirectionType = CGScrollDirectionTypeRight;
    }else {
        horizontalDirectionType = CGScrollDirectionTypeStop;
    }
    
    if (_endPoint.y > _startPoint.y) {
        verticalDirectionType   = CGScrollDirectionTypeDown;
    }else if (_endPoint.y < _startPoint.y) {
        verticalDirectionType   = CGScrollDirectionTypeUp;
    }else {
        verticalDirectionType   = CGScrollDirectionTypeStop;
    }
    
    self.scrollDirectionType    = horizontalDirectionType | verticalDirectionType;
    
    CGFloat horizontalVelocity  = _endPoint.x - _startPoint.x;
    self.horizontalMeanVelocity += horizontalVelocity;
    self.horizontalMeanVelocity /= 2.0;
    
    CGFloat verticalVelocity    = _endPoint.y - _startPoint.y;
    self.verticalMeanVelocity   += verticalVelocity;
    self.verticalMeanVelocity   /= 2.0;
    
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [scrollView.delegate_cg scrollViewDidScroll:scrollView];
    }
    
    _startPoint = _endPoint;
}

- (void)scrollViewDidZoom:(CGScrollView *)scrollView
{
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [scrollView.delegate_cg scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(CGScrollView *)scrollView
{
    self.scrollControlType  = CGScrollControlTypeDragging;
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [scrollView.delegate_cg scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(CGScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [scrollView.delegate_cg scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(CGScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        self.scrollControlType  = CGScrollControlTypeNone;
    }else {
        self.scrollControlType  = CGScrollControlTypeEndDraggingWillDecelerating;
    }
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [scrollView.delegate_cg scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(CGScrollView *)scrollView
{
    self.scrollControlType  = CGScrollControlTypeDecelerating;
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [scrollView.delegate_cg scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(CGScrollView *)scrollView
{
    self.scrollControlType      = CGScrollControlTypeNone;
    self.scrollDirectionType    = CGScrollDirectionTypeStop;
    [self setupInitialPoint:scrollView.contentOffset];
    
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [scrollView.delegate_cg scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(CGScrollView *)scrollView
{
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [scrollView.delegate_cg scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (nullable UIView *)viewForZoomingInScrollView:(CGScrollView *)scrollView
{
    if ([scrollView.delegate_cg respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [scrollView.delegate_cg viewForZoomingInScrollView:scrollView];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(CGScrollView *)scrollView withView:(nullable UIView *)view
{
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [scrollView.delegate_cg scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(CGScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [scrollView.delegate_cg scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(CGScrollView *)scrollView
{
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [scrollView.delegate_cg scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(CGScrollView *)scrollView
{
    if ([scrollView.delegate_cg respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [scrollView.delegate_cg scrollViewDidScrollToTop:scrollView];
    }
}

#pragma mark - 设置属性
- (void)setScrollControlType:(CGScrollControlType)scrollControlType
{
    _scrollControlType  = scrollControlType;
    if (CGScrollControlTypeNone == scrollControlType) {
        [self clearMeanVelocity];
    }
}

@end
