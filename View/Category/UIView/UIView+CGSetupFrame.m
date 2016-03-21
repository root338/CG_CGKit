//
//  UIView+CGSetupFrame.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIView+CGSetupFrame.h"

//typedef NS_OPTIONS(NSInteger, CGViewSetupFrameType) {
//
//    CGViewSetupFrameTypeOriginX = 1 << 0,
//    CGViewSetupFrameTypeOriginY = 1 << 1,
//    CGViewSetupFrameTypeWidth   = 1 << 2,
//    CGViewSetupFrameTypeHeight  = 1 << 3,
//    
//    CGViewSetupFrameTypeOrigin  = CGViewSetupFrameTypeOriginX | CGViewSetupFrameTypeOriginY,
//    CGViewSetupFrameTypeSize    = CGViewSetupFrameTypeWidth | CGViewSetupFrameTypeHeight,
//};

@implementation UIView (CGSetupFrame)

@dynamic xOrigin, yOrigin, origin, xCenter, yCenter;
@dynamic width, height, size;
@dynamic minX, minY, midX, midY, maxX, maxY;

#pragma mark - 坐标设置
- (CGFloat)xOrigin
{
    return self.origin.x;
}

- (void)setXOrigin:(CGFloat)xOrigin
{
    CGRect frame = self.frame;
    if (frame.origin.x != xOrigin) {
        frame.origin.x = xOrigin;
        self.frame = frame;
    }
}

- (CGFloat)yOrigin
{
    return self.origin.y;
}

- (void)setYOrigin:(CGFloat)yOrigin
{
    CGRect frame = self.frame;
    if (frame.origin.y != yOrigin) {
        frame.origin.y = yOrigin;
        self.frame = frame;
    }
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    if (!CGPointEqualToPoint(origin, frame.origin)) {
        frame.origin = origin;
        self.frame = frame;
    }
}

- (CGFloat)xCenter
{
    return self.center.x;
}

- (void)setXCenter:(CGFloat)xCenter
{
    CGPoint center = self.center;
    if (center.x != xCenter) {
        center.x = xCenter;
        self.center = center;
    }
}

- (CGFloat)yCenter
{
    return self.center.y;
}

- (void)setYCenter:(CGFloat)yCenter
{
    CGPoint center = self.center;
    if (center.y != yCenter) {
        center.y = yCenter;
        self.center = center;
    }
}

#pragma mark - 大小设置
- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    if (frame.size.width != width) {
        frame.size.width = width;
        self.frame = frame;
    }
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    if (frame.size.height != height) {
        frame.size.height = height;
        self.frame = frame;
    }
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    if (!CGSizeEqualToSize(size, frame.size)) {
        frame.size = size;
        self.frame = frame;
    }
}

#pragma mark - 显示区域获取
- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)midX
{
    return CGRectGetMidX(self.frame);
}

- (CGFloat)midY
{
    return CGRectGetMidY(self.frame);
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

//- (void)setupViewOriginWithX:(NSNumber *)x y:(NSNumber *)y
//{
//    [self setupViewFrameWithOriginX:x originY:y width:nil height:nil];
//}
//
//- (void)setupViewSizeWithWidth:(NSNumber *)width height:(NSNumber *)height
//{
//    [self setupViewFrameWithOriginX:nil originY:nil width:width height:height];
//}
//
//- (void)setupViewFrameWithOriginX:(NSNumber *)originX originY:(NSNumber *)originY width:(NSNumber *)width height:(NSNumber *)height
//{
//    CGFloat x = originX ? originX.floatValue : self.xOrigin;
//    CGFloat y = originY ? originY.floatValue : self.yOrigin;
//    CGFloat w = width   ? width.floatValue      : self.width;
//    CGFloat h = height  ? height.floatValue     : self.height;
//    
//    CGRect newFrame = CGRectMake(x, y, w, h);
//    
//    if (!CGRectContainsRect(newFrame, self.frame)) {
//        self.frame = newFrame;
//    }
//}
#pragma mark

- (void)cg_setupCenterWithView:(UIView *)paramView
{
    self.center = [self cg_centerOriginWithTargetView:paramView];
}

- (void)cg_setupFrameWithCenter:(CGPoint)paramCenter size:(CGSize)paramSize
{
    self.center = paramCenter;
    self.size   = paramSize;
}

- (CGPoint)cg_centerOrigin
{
    if (!self.superview) {
        return CGPointZero;
    }
    return [self cg_centerOriginWithTargetView:self.superview];
}

- (CGPoint)cg_centerOriginWithTargetView:(UIView *)targetView
{
    return CGPointMake(targetView.width / 2.0, targetView.height / 2.0);
}

@end
