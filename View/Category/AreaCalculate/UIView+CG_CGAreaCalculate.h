//
//  UIView+CG_CGAreaCalculate.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - CGFloat
/** 计算 maxWith - (left + right) */
CG_INLINE CGFloat CG_CGWidthWithMaxWidth(CGFloat maxWidth, UIEdgeInsets edgeInsets)
{
    return maxWidth - (edgeInsets.left + edgeInsets.right);
}

/** 计算 maxHeight - (top + bottom) */
UIKIT_STATIC_INLINE CGFloat CG_CGHeightWithMaxHeight(CGFloat maxHeight, UIEdgeInsets edgeInsets)
{
    return maxHeight - (edgeInsets.top + edgeInsets.bottom);
}

/** 计算 left + width + right */
UIKIT_STATIC_INLINE CGFloat CG_CGMaxWidthWithWidth(CGFloat width, UIEdgeInsets edgeInsets)
{
    return edgeInsets.left + width + edgeInsets.right;
}

/** 计算 top + height + bottom */
UIKIT_STATIC_INLINE CGFloat CG_CGMaxHeightWithHeight(CGFloat height, UIEdgeInsets edgeInsets)
{
    return edgeInsets.top + height + edgeInsets.bottom;
}

/** 计算视图 中心 x 坐标 */
UIKIT_STATIC_INLINE CGFloat CG_CGCenterOriginX(CGFloat viewWidth, CGFloat superviewWidth) {
    return (superviewWidth - viewWidth) / 2.0;
}

/** 计算视图 中心 y 坐标 */
UIKIT_STATIC_INLINE CGFloat CG_CGCenterOriginY(CGFloat viewHeight, CGFloat superviewHeight) {
    return (superviewHeight - viewHeight) / 2.0;
}

#pragma mark - CGSize
/** 计算 { maxWith - (left + right), maxHeight - (top + bottom) } */
UIKIT_STATIC_INLINE CGSize CG_CGSizeWidthMaxSize(CGSize maxSize, UIEdgeInsets edgeInsets)
{
    return CGSizeMake(CG_CGWidthWithMaxWidth(maxSize.width, edgeInsets), CG_CGHeightWithMaxHeight(maxSize.height, edgeInsets));
}

/** 计算 { left + width + right, top + height + bottom } */
UIKIT_STATIC_INLINE CGSize CG_CGMaxSizeWidthSize(CGSize size, UIEdgeInsets edgeInsets)
{
    return CGSizeMake(CG_CGMaxWidthWithWidth(size.width, edgeInsets), CG_CGMaxHeightWithHeight(size.height, edgeInsets));
}

/** 获取两个CGSize值中更小的width和height */
UIKIT_STATIC_INLINE CGSize CG_CGMinSize(CGSize s1, CGSize s2)
{
    return CGSizeMake(MIN(s1.width, s2.width), MIN(s1.height, s2.height));
}

/** 获取两个CGSize值中更大的width和height */
UIKIT_STATIC_INLINE CGSize CG_CGMaxSize(CGSize s1, CGSize s2)
{
    return CGSizeMake(MAX(s1.width, s2.width), MAX(s1.height, s2.height));
}
/// {s1.width + s2.width, s1.height + s2.height}
UIKIT_STATIC_INLINE CGSize CG_CGSizeAddSize(CGSize s1, CGSize s2)
{
    return CGSizeMake(s1.width + s2.width, s1.height + s2.height);
}
/// {s1.width + width, s1.height + height}
UIKIT_STATIC_INLINE CGSize CG_CGSizeAddValue(CGSize s1, CGFloat width, CGFloat height)
{
    return CGSizeMake(s1.width + width, s1.height + height);
}

#pragma mark - CGPoint

UIKIT_STATIC_INLINE BOOL CG_CGPointIsNAN(CGPoint p1) {
    return isnan(p1.x) || isnan(p1.y);
}

/** 计算 { p1.x + x, p1.y + y } */
UIKIT_STATIC_INLINE CGPoint CG_CGPointWithOffset(CGPoint p1, CGFloat x, CGFloat y)
{
    return CGPointMake(p1.x + x, p1.y + y);
}

/** 计算 { p1.x + p2.x, p1.y + p2.y } */
UIKIT_STATIC_INLINE CGPoint CG_CGPointWithOffsetPoint(CGPoint p1, CGPoint p2)
{
    return  CG_CGPointWithOffset(p1, p2.x, p2.y);
}

/** 获取 s1 的中心点 */
UIKIT_STATIC_INLINE CGPoint CG_CGCenterWithSize(CGSize s1)
{
    return CGPointMake(s1.width / 2.0, s1.height / 2.0);
}

/** 获取 s2 在 s1 居中时的起始坐标 */
UIKIT_STATIC_INLINE CGPoint CG_CGCenterOriginWith(CGSize s1, CGSize s2)
{
    return CGPointMake((s1.width - s2.width) / 2.0, (s1.height - s2.height) / 2.0);
}

/** 获取view在父视图的中心坐标下的起始坐标 */
UIKIT_STATIC_INLINE CGPoint CG_CGCenterPointWith(UIView *superview, UIView *view)
{
    return CGPointMake((CGRectGetWidth(superview.bounds) - CGRectGetWidth(view.bounds)) / 2.0, (CGRectGetHeight(superview.bounds) - CGRectGetHeight(view.bounds)) / 2.0);
}

UIKIT_STATIC_INLINE CGPoint CG_CGMidPointWith(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) / 2.0, (p1.y + p2.y) / 2.0);
}
/// {MIN(p1.x, p2.x), MIN(p1.y, p2.y)}
UIKIT_STATIC_INLINE CGPoint CG_CGMinPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake(MIN(p1.x, p2.x), MIN(p1.y, p2.y));
}
// {MAX(p1.x, p2.x), MAX(p1.y, p2.y)}
UIKIT_STATIC_INLINE CGPoint CG_CGMaxPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake(MAX(p1.x, p2.x), MAX(p1.y, p2.y));
}

#pragma mark - CGRect

UIKIT_STATIC_INLINE CGRect CG_CGRect(CGPoint p, CGSize s)
{
    return CGRectMake(p.x, p.y, s.width, s.height);
}

/** 计算 { { left, top }, { width - (left + right), height - (top + bottom) } } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithMargin(CGRect rect, UIEdgeInsets edgeInsets)
{
    return CGRectMake(edgeInsets.left, edgeInsets.top, CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets), CG_CGHeightWithMaxHeight(CGRectGetHeight(rect), edgeInsets));
}
/** 计算 { { midX - size.width / 2, midY - size.height / 2 }, { size } */
UIKIT_STATIC_INLINE CGRect CG_CGRectCenterFrame(CGRect rect, CGSize size)
{
    return CGRectMake(CGRectGetMidX(rect) - size.width / 2,
                      CGRectGetMidY(rect) - size.height / 2,
                      size.width, size.height);
}

/** 计算 { { originX - left, originY - top}, { width + left + right, height + top + bottom } } */
UIKIT_STATIC_INLINE CGRect CG_CGFrameWithMargin(CGRect frame, UIEdgeInsets edgeInsets)
{
    return CGRectMake(CGRectGetMinX(frame) - edgeInsets.left, CGRectGetMinY(frame) - edgeInsets.top, CGRectGetWidth(frame) + edgeInsets.left + edgeInsets.right, CGRectGetHeight(frame) + edgeInsets.top + edgeInsets.bottom);
}

/** 计算 { { originX + left, originY + top}, { width - left - right, height - top - bottom } } */
UIKIT_STATIC_INLINE CGRect CG_CGFrameWithMaxFrame(CGRect frame, UIEdgeInsets edgeInsets)
{
    return CGRectMake(CGRectGetMinX(frame) + edgeInsets.left, CGRectGetMinY(frame) + edgeInsets.top, CG_CGWidthWithMaxWidth(CGRectGetWidth(frame), edgeInsets), CG_CGHeightWithMaxHeight(CGRectGetHeight(frame), edgeInsets));
}

/** 计算 { { 0, 0}, { width, height } } */
UIKIT_STATIC_INLINE CGRect CG_CGBoundsWithFrame(CGRect frame)
{
    return CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
}

/** 计算 { { 0, 0 }, { width + (left + right), height + (top + bottom) } } */
UIKIT_STATIC_INLINE CGRect CG_CGMaxBoundsWithRectMargin(CGRect rect, UIEdgeInsets edgeInsets)
{
    return CGRectMake(0, 0, CG_CGMaxWidthWithWidth(CGRectGetWidth(rect), edgeInsets), CG_CGMaxHeightWithHeight(CGRectGetHeight(rect), edgeInsets));
}

/** 忽略顶部 计算 { { x + left, offsetY }, { width - (left + right), height - (offsetY + bottom) } } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeTop(CGRect rect, UIEdgeInsets edgeInsets, CGFloat offsetY)
{
    return CGRectMake(CGRectGetMinX(rect) + edgeInsets.left, CGRectGetMinY(rect) + offsetY, CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets), rect.size.height - (offsetY + edgeInsets.bottom));
}

/// 忽略底部 计算 { { x + left, y + top }, { width - (left + right), height} }
/// @param height 高度，== -1，使用 宽度
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeBottom(CGRect rect, UIEdgeInsets edgeInsets, CGFloat height)
{
    CGFloat width = CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets);
    if (height == -1) {
        height = width;
    }
    return CGRectMake(CGRectGetMinX(rect) + edgeInsets.left, CGRectGetMinY(rect) + edgeInsets.top, width, height);
}

/// 忽略垂直 计算 { { x + left, y + offsetY }, { width - (left + right), height } }
/// @param height 高度，== -1，使用 宽度
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeVertical(CGRect rect, UIEdgeInsets edgeInsets, CGFloat offsetY, CGFloat height)
{
    CGFloat width = CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets);
    if (height == -1) {
        height = width;
    }
    return CGRectMake(CGRectGetMinX(rect) + edgeInsets.left, CGRectGetMinY(rect) + offsetY, width, height);
}

/// 忽略右边 计算 { {x + left, y + top }, { width , height - (top + bottom) } }
/// @param rect 可用区域
/// @param edgeInsets 外边距
/// @param width 宽度，如果== -1，使用 高度
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeRight(CGRect rect, UIEdgeInsets edgeInsets, CGFloat width)
{
    CGFloat height = CG_CGHeightWithMaxHeight(CGRectGetHeight(rect), edgeInsets);
    if (width == -1) {
        width = height;
    }
    return CGRectMake(CGRectGetMinX(rect) + edgeInsets.left, CGRectGetMinY(rect) + edgeInsets.top, width, height);
}

/** 忽略左边 计算 { { x + offsetX, y + top }, { width - (offsetX + right), height - (top + bottom) } }  */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeLeft(CGRect rect, UIEdgeInsets edgeInsets, CGFloat offsetX) {
    return CGRectMake(CGRectGetMinX(rect) + offsetX, CGRectGetMinY(rect) + edgeInsets.top, CGRectGetWidth(rect) - (offsetX + edgeInsets.right), CG_CGHeightWithMaxHeight(CGRectGetHeight(rect), edgeInsets));
}

/// 忽略水平 计算 { { x + offsetX, y + top }, { width , height - (top + bottom) }
/// @param width 宽度，如果== -1，使用 高度
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeHorizontal(CGRect rect, UIEdgeInsets edgeInsets, CGFloat offsetX, CGFloat width)
{
    CGFloat height = CG_CGHeightWithMaxHeight(CGRectGetHeight(rect), edgeInsets);
    if (width == -1) {
        width = height;
    }
    return CGRectMake(CGRectGetMinX(rect) + offsetX, CGRectGetMinY(rect) + edgeInsets.top, width, height);
}

/** 计算 { position, size } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithMake(CGPoint position, CGSize size)
{
    return CGRectMake(position.x, position.y, size.width, size.height);
}

/** 计算 { {center.x - width / 2, centr.y - height / 2 }, size } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithCenterMake(CGPoint center, CGSize size)
{
    return CGRectMake(center.x - size.width / 2.0, center.y - size.height / 2.0, size.width, size.height);
}
/** size 在可用区域(availableRect)内，垂直居中 */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithCenterVertical(CGRect availableRect, CGSize size)
{
    return CGRectMake(CGRectGetMinX(availableRect), CGRectGetMinY(availableRect) + (CGRectGetHeight(availableRect) - size.height) / 2, size.width, size.height);
}
/** size 在可用区域(availableRect)内，水平居中 */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithCenterHorizontal(CGRect availableRect, CGSize size)
{
    return CGRectMake(CGRectGetMinX(availableRect) + (CGRectGetWidth(availableRect) - size.width) / 2, CGRectGetMinY(availableRect), size.width, size.height);
}

UIKIT_STATIC_INLINE CGRect CG_CGRectContentMode(CGRect totalRect, CGSize targetSize, UIViewContentMode mode)
{
    CGRect frame = CGRectZero;
    CGSize totalSize = totalRect.size;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = targetSize.width;
    CGFloat height = targetSize.height;
    
    switch (mode) {
        case UIViewContentModeScaleAspectFit:
        case UIViewContentModeScaleAspectFill:
        {
            
            CGFloat s1 = targetSize.width / totalSize.width;
            CGFloat s2 = targetSize.height / totalSize.height;
            
            if (s1 < s2) {
                if (UIViewContentModeScaleAspectFit == mode) {
                    width   = targetSize.width / s2;
                    height  = totalSize.height;
                }else {
                    width   = totalSize.width;
                    height  = targetSize.height / s1;
                }
            }else {
                if (UIViewContentModeScaleAspectFit == mode) {
                    width   = totalSize.width;
                    height  = targetSize.height / s1;
                }else {
                    width   = targetSize.width / s2;
                    height  = totalSize.height;
                }
            }
            
            x = CG_CGCenterOriginX(width, totalSize.width);
            y = CG_CGCenterOriginY(height, totalSize.height);
            break;
        }
        case UIViewContentModeScaleToFill:
            width = totalSize.width;
            height = totalSize.height;
            break;
        case UIViewContentModeTop:
            x = CG_CGCenterOriginX(targetSize.width, totalSize.width);
            break;
        case UIViewContentModeTopRight:
            x = totalSize.width - targetSize.width;
            break;
        case UIViewContentModeRight:
            x = totalSize.width - targetSize.width;
            y = CG_CGCenterOriginY(targetSize.height, totalSize.height);
            break;
        case UIViewContentModeBottomRight:
            x = totalSize.width - targetSize.width;
            y = totalSize.height - targetSize.height;
            break;
        case UIViewContentModeBottom:
            x = CG_CGCenterOriginX(targetSize.width, totalSize.width);
            y = totalSize.height - targetSize.height;
            break;
        case UIViewContentModeBottomLeft:
            y = totalSize.height - targetSize.height;
            break;
        case UIViewContentModeLeft:
            y = CG_CGCenterOriginY(targetSize.height, totalSize.height);
            break;
        case UIViewContentModeCenter:
            x = CG_CGCenterOriginX(targetSize.width, totalSize.width);
            y = CG_CGCenterOriginY(targetSize.height, totalSize.height);
            break;
        default:
            break;
    }
    
    frame = CGRectMake(x + CGRectGetMinX(totalRect), y + CGRectGetMinY(totalRect), width, height);
    
    return frame;
}
