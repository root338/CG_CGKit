//
//  MLPageControl.m
//  TestCG_CGKit
//
//  Created by PCG on 2018/5/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MLPageControl.h"


@interface MLPageControlCell : UIView
@end
@implementation MLPageControlCell
@end

@interface MLPageControl ()
{
    
}
/// 内部选择 page Index
@property (nonatomic, assign) NSInteger mCurrentPage;
@property (nonatomic, assign) BOOL updateDisplayMark;

@property (nonatomic, strong) NSMutableArray<MLPageControlCell *> *pageControls;
@property (nonatomic, strong) NSMutableArray<MLPageControlCell *> *cachePageControls;

@end

@implementation MLPageControl

@synthesize currentPage = _currentPage;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _insets     = UIEdgeInsetsMake(18, 8, 18, 8);
        _pageSize   = CGSizeMake(7, 7);
        _pageSpace  = 9;
        _disableFaultTolerant       = NO;
        _pageVerticalAlignment      = CGViewVerticalAlignmentCenter;
        _pageHorizontalAlignment    = CGViewAlignmentHorizontalCenter;
    }
    return self;
}

- (void)updateCurrentPageDisplay
{
    
}

- (void)setNeedsUpdateDisplay
{
    self.updateDisplayMark  = YES;
    if (self.window) {
        [self updateDisplayIfNeeded];
    }
}

- (void)updateDisplayIfNeeded
{
    if (!self.updateDisplayMark) {
        return;
    }
    [self updateContentSubviews];
    [self updateContentLayout];
    self.updateDisplayMark  = NO;
}
/// 更新子视图
- (void)updateContentSubviews
{
    if (self.pageControls.count != self.numberOfPages) {
        // 添加/移除page
        if (self.pageControls.count > self.numberOfPages) {
            [self removePageControlCellWithRange:NSMakeRange(self.numberOfPages, self.pageControls.count - self.numberOfPages)];
        }else if (self.pageControls.count < self.numberOfPages) {
            [self addPageControlCellsWithRange:NSMakeRange(self.pageControls.count, self.numberOfPages - self.pageControls.count)];
        }
    }
    [self updateCurrentPageTintColor];
    [self updateOtherPageTintColor];
}
/// 更新布局
- (void)updateContentLayout
{
    NSInteger pageTotal = _pageControls.count;
    if (pageTotal == 0) {
        return;
    }
    
    CGFloat width   = CGRectGetWidth(self.frame);
    CGFloat height  = CGRectGetHeight(self.frame);
    
    CGSize pageTotalSize = CGSizeMake(self.pageSize.width * pageTotal + self.pageSpace * (pageTotal - 1), self.pageSize.height);
    CGPoint startPoint = CGPointZero;
    switch (self.pageVerticalAlignment) {
        case CGViewVerticalAlignmentTop:
            startPoint.y = self.insets.top;
            break;
        case CGViewVerticalAlignmentBottom:
            startPoint.y = height - self.insets.bottom - pageTotalSize.height;
            break;
        default:
            startPoint.y = (height - pageTotalSize.height) / 2.0;
            break;
    }
    switch (self.pageHorizontalAlignment) {
        case CGViewAlignmentHorizontalLeft:
            startPoint.x = self.insets.left;
            break;
        case CGViewAlignmentHorizontalRight:
            startPoint.x = width - pageTotalSize.width - self.insets.right;
            break;
        default:
            startPoint.x = (width - pageTotalSize.width) / 2.0;
            break;
    }
    [_pageControls enumerateObjectsUsingBlock:^(MLPageControlCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect pageFrame = CGRectMake(startPoint.x + idx * (self.pageSize.width + self.pageSpace), startPoint.y, self.pageSize.width, self.pageSize.height);
        if (!CGRectEqualToRect(pageFrame, obj.frame)) {
            obj.frame = pageFrame;
        }
    }];
}

- (void)removePageControlCellWithRange:(NSRange)range
{
    for (NSInteger index = range.location; index < range.location + range.length; index++) {
        if (self.pageControls.count > index) {
            [self removePageControlCellAtIndex:index];
        }else {
            break;
        }
    }
}

- (MLPageControlCell *)removePageControlCellAtIndex:(NSInteger)index
{
    MLPageControlCell *cell = self.pageControls[index];
    [cell removeFromSuperview];
    [self.pageControls removeObject:cell];
    [self.cachePageControls addObject:cell];
    return cell;
}

- (void)addPageControlCellsWithRange:(NSRange)range
{
    for (NSInteger index = range.location; index < range.location + range.length; index++) {
        [self addPageControlCellAtIndex:index];
    }
}

- (MLPageControlCell *)addPageControlCellAtIndex:(NSInteger)index
{
    MLPageControlCell *cell = nil;
    if (_cachePageControls.count > 0) {
        cell = _cachePageControls.lastObject;
        [_cachePageControls removeLastObject];
    }else {
        cell = [[MLPageControlCell alloc] init];
    }
    
    [self.pageControls addObject:cell];
    [self addSubview:cell];
    return cell;
}

- (void)updateCurrentPageTintColor
{
    
    if (self.mCurrentPage >= 0 && self.mCurrentPage < self.pageControls.count) {
        MLPageControlCell *cell = self.pageControls[self.mCurrentPage];
        if (cell.backgroundColor != self.currentPageIndicatorTintColor) {
            cell.backgroundColor = self.currentPageIndicatorTintColor;
        }
    }
}

- (void)updateOtherPageTintColor
{
    [self.pageControls enumerateObjectsUsingBlock:^(MLPageControlCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx != self.mCurrentPage) {
            if (obj.backgroundColor != self.pageIndicatorTintColor) {
                obj.backgroundColor = self.pageIndicatorTintColor;
            }
        }
    }];
}

#pragma mark - 重写系统方法
- (CGSize)intrinsicContentSize
{
    NSInteger pageTotalCount = self.numberOfPages;
    CGFloat width = self.pageSize.width * pageTotalCount + (pageTotalCount - 1) * self.pageSpace + self.insets.left + self.insets.right;
    CGFloat height = self.insets.top + self.pageSize.height + self.insets.bottom;
    return CGSizeMake(width, height);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateContentLayout];
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        if (self.updateDisplayMark) {
            [self updateDisplayIfNeeded];
        }
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [super touchesMoved:touches withEvent:event];
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//}

#pragma mark - Properties

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    if (_numberOfPages != numberOfPages) {
        [self setNeedsUpdateDisplay];
        _numberOfPages = numberOfPages;
    }
}

- (void)setPageSize:(CGSize)pageSize
{
    if (!CGSizeEqualToSize(_pageSize, pageSize)) {
        _pageSize = pageSize;
        [self setNeedsUpdateDisplay];
    }
}

- (void)setInsets:(UIEdgeInsets)insets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_insets, insets)) {
        _insets = insets;
        [self setNeedsUpdateDisplay];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    if (_currentPage != currentPage) {
        _currentPage    = currentPage;
        _mCurrentPage   = currentPage;
        [self setNeedsUpdateDisplay];
    }
}

- (NSInteger)currentPage
{
    if (self.disableFaultTolerant) {
        return self.mCurrentPage;
    }else {
        return _currentPage;
    }
}

- (NSInteger)mCurrentPage
{
    if (self.disableFaultTolerant) {
        if (_currentPage < 0) {
            return 0;
        }else if (_currentPage < self.numberOfPages) {
            return _mCurrentPage = self.numberOfPages;
        }else {
            return _currentPage;
        }
    }else {
        return _currentPage;
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    if (_pageIndicatorTintColor != pageIndicatorTintColor) {
        _pageIndicatorTintColor = pageIndicatorTintColor;
        [self setNeedsUpdateDisplay];
    }
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    if (_currentPageIndicatorTintColor != currentPageIndicatorTintColor) {
        _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
        [self setNeedsUpdateDisplay];
    }
}

- (NSMutableArray<MLPageControlCell *> *)pageControls
{
    if (_pageControls) {
        return _pageControls;
    }
    _pageControls = [NSMutableArray array];
    return _pageControls;
}

- (NSMutableArray<MLPageControlCell *> *)cachePageControls
{
    if (_cachePageControls) {
        return _cachePageControls;
    }
    _cachePageControls = [NSMutableArray array];
    return _cachePageControls;
}

@end
