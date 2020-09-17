//
//  CGZoomImageView.m
//  Corp
//
//  Created by 345 on 15/2/2.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "CGImageView.h"

#import "UIScrollView+CGCreate.h"
#import "UIView+CGAddConstraints.h"
#import "UIView+CGAddGestureRecognizer.h"

@interface _CGImageView : UIImageView

@property (nullable, nonatomic, copy) void (^setupImageCallback) (void);

@end

@implementation _CGImageView

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    if (self.setupImageCallback) {
        self.setupImageCallback();
    }
}

@end

@interface CGImageView ()<UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    
}

@property (nonatomic, strong) _CGImageView *imageBrowseView;
@property (nonatomic, strong, readwrite) UIScrollView *imageScrollView;

@property (nullable, nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;
@property (nullable, nonatomic, strong) UITapGestureRecognizer *singleTapGesture;

@end

@implementation CGImageView


#pragma mark - 事件处理
- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    CGFloat newScale        = 0;
    
    if (self.imageScrollView.zoomScale < self.imageScrollView.maximumZoomScale) {
        newScale    = self.imageScrollView.zoomScale * self.zoomMultiple;
    }else {
        newScale    = self.imageScrollView.zoomScale / self.zoomMultiple;
    }
    
    CGRect zoomRect     = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [self.imageScrollView zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center
{
    CGRect  zoomRect = CGRectZero;
    
    zoomRect.size.width     = self.imageScrollView.width  * scale;
    zoomRect.size.height    = self.imageScrollView.height * scale;
    
    zoomRect.origin.x       = center.x - CGRectGetWidth(zoomRect)  / 2;
    zoomRect.origin.y       = center.y - CGRectGetHeight(zoomRect) / 2;
    return zoomRect;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.disableScale ? nil : self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    UIView *view = [self viewForZoomingInScrollView:scrollView];
    if (view == nil) {
        return;
    }
    CGPoint viewPoint;
    viewPoint.x = MAX(scrollView.width - view.width, 0) / 2.0;
    viewPoint.y = MAX(scrollView.height - view.height, 0) / 2.0;
    //    [UIView animateWithDuration:0.3 animations:^{
    view.origin = viewPoint;
    //    }];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.doubleTapGesture) {
        return !self.disableDoubleScale;
    }
    return YES;
}

#pragma mark - 添加、设置视图和布局
- (void)initialization
{
    _imageBrowseView  = [[_CGImageView alloc] init];
    _imageBrowseView.contentMode  = UIViewContentModeScaleAspectFit;
    
    __weak typeof(self) weakSelf    = self;
    _imageBrowseView.setupImageCallback = ^{
        
        [weakSelf setupImageBrowseSize];
    };
    
    _imageScrollView = [UIScrollView cg_createWithScrollViewWithShowScrollIndicator:NO];
    _imageScrollView.delegate   = self;
    
    [_imageScrollView addSubview:_imageBrowseView];
    [self addSubview:_imageScrollView];
    
    [self setupImageBrowseSize];
}

- (void)setupImageBrowseSize
{
    CGSize imageBrowseSize;
    if (!self.imageBrowseView.image || self.imageViewSizeEqualViewSize) {
        
        imageBrowseSize = self.size;
    }else {
        
        CGFloat width   = self.width;
        CGFloat height  = MAX(self.height, 1) ;
        CGSize imageSize    = self.imageBrowseView.image.size;
        CGFloat imageWidth  = imageSize.width;
        CGFloat imageHeight = MAX(1, imageSize.height);
        
        if (width / height <= imageWidth / imageHeight) {
            imageBrowseSize = CGSizeMake(width, (imageHeight * width) / imageWidth);
        }else {
            imageBrowseSize = CGSizeMake((imageWidth * height) / imageHeight, height);
        }
    }
    self.imageBrowseView.size   = imageBrowseSize;
    self.imageBrowseView.center = self.imageScrollView.center;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageScrollView.frame  = self.bounds;
    [self setupImageBrowseSize];
}

#pragma mark - 设置手势
- (void)didMoveToWindow
{
    [super didMoveToWindow];
    [self setupGestureRecognizer];
}

- (void)setupGestureRecognizer
{
    if (self.window) {
        //当视图加载到窗口时
        if (!self.disableScale) {
            //当开启缩放时
            if (!self.disableDoubleScale) {
                //当开启双击缩放时
                if (!self.doubleTapGesture) {
                    //创建手势
                    self.doubleTapGesture   = [self cg_addGestureRecognizerWithType:CGGestureRecognizerTypeTap action:@selector(handleDoubleTap:)];
                    self.doubleTapGesture.numberOfTapsRequired      = 2;
                    self.doubleTapGesture.delegate                  = self;
                    [self cg_requireGestureRecognizerToFail];
                }
            }
        }
    }
}

/** 设置单击、双击同时执行 */
- (void)cg_requireGestureRecognizerToFail
{
    if (self.singleTapGesture && self.doubleTapGesture) {
        
        //当设置时，双击时，单击不会执行。否则双击时，单击会提前执行
        [self.singleTapGesture requireGestureRecognizerToFail:self.doubleTapGesture];
    }
}

- (void)addSingleTapTarget:(id)target action:(SEL)action
{
    if (!self.singleTapGesture) {
        self.singleTapGesture   = [self cg_addGestureRecognizerWithType:CGGestureRecognizerTypeTap target:target action:action];
        [self cg_requireGestureRecognizerToFail];
    }else {
        [self.singleTapGesture addTarget:target action:action];
    }
}

- (void)removeSingleTapTarget:(id)target action:(SEL)action
{
    if (!self.singleTapGesture) {
        return;
    }
    
    [self.singleTapGesture removeTarget:target action:action];
}

#pragma mark - 设置属性
- (void)setDisableDoubleScale:(BOOL)disableDoubleScale
{
    if (_disableDoubleScale != disableDoubleScale) {
        
        _disableDoubleScale = disableDoubleScale;
        [self setupGestureRecognizer];
    }
}

- (void)setDisableScale:(BOOL)disableScale
{
    if (_disableScale != disableScale) {
        
        _disableScale   = disableScale;
        [self setupGestureRecognizer];
    }
}

- (UIImageView *)imageView
{
    return self.imageBrowseView;
}

@end
