//
//  CGButton.m
//  QuickAskCommunity
//
//  Created by DY on 16/1/15.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGButton.h"

#import "UIView+CGSetupFrame.h"
#import "UIButton+UpdateLocate.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "NSObject+CGDelaySelector.h"

#import "CGPrintLogHeader.h"

typedef NS_ENUM(NSInteger, _CGButtonContentType) {

    _CGButtonContentTypeContentView,
    _CGButtonContentTypeImageView,
    _CGButtonContentTypeTitleLabel,
};

@interface CGButton ()
{
    ///YES表示正在cg_calculateAreaWithContentType:contentRect:方法中处理布局,
    BOOL _isCalculateAreaButtonContentView;
}

@property (nonatomic, strong) UILabel *tempCalculateLabel;
@end

@implementation CGButton

- (void)initialization
{
    [super initialization];
}

#pragma mark - 重置按钮布局
- (void)cg_updateButtonLayout
{
//    [NSObject cancelPreviousPerformRequestsWithTarget:self
//                                             selector:@selector(cg_updateButtonLayout)
//                                               object:nil];
    
    [self setNeedsLayout];
}

///获取contentView最大的区域
//- (CGRect)cg_calculateMaxContentRect:(CGRect)contentRect
//{
//    CGRect paramContentRect = contentRect;
//    if (!CGSizeEqualToSize(self.maxSize, CGSizeZero)) {
//        
//        paramContentRect.size = CG_CGMinSize(contentRect.size, CG_CGSizeWidthMaxSize(self.maxSize, self.marginEdgeInsets));
//    }
//    return paramContentRect;
//}

///计算图片在按钮中最适合的大小
- (CGSize)cg_calculateImageSizeWithContentRect:(CGRect)contentRect
{
    BOOL useCustomImageView = !CGSizeEqualToSize(self.imageViewSize, CGSizeZero);
    if (!self.currentImage && !useCustomImageView) {
        return CGSizeZero;
    }
    
    CGSize imageSize = useCustomImageView ? self.imageViewSize : self.currentImage.size;
        
    imageSize   = CG_CGMinSize(contentRect.size, imageSize);
    
    if (self.buttonStyle == CGButtonStyleHorizonalLeft || self.buttonStyle == CGButtonStyleHorizonalRight) {
        
        CGFloat contentWidth    = CGRectGetWidth(contentRect);
        if (imageSize.width + self.space > contentWidth) {
            imageSize.width     = contentWidth - self.space;
        }
        
    }else {
        
        CGFloat contentHeight   = CGRectGetHeight(contentRect);
        if (imageSize.height + self.space > contentHeight) {
            imageSize.height    = contentHeight - self.space;
        }
        
    }
    
    return imageSize;
}

///计算标题在按钮中最适合的大小
- (CGSize)cg_calculateTitleSizeWithContentRect:(CGRect)contentRect imageSize:(CGSize)imageSize
{
    CGSize tempLabelSize        = contentRect.size;
    
    //获取标题的最大区域
    if (self.buttonStyle == CGButtonStyleHorizonalRight || self.buttonStyle == CGButtonStyleHorizonalLeft) {
        
        tempLabelSize.width     = CGRectGetWidth(contentRect) - (imageSize.width + self.space);
    }else {
        
        tempLabelSize.height    = CGRectGetHeight(contentRect) - (imageSize.height + self.space);
    }
    
    /** 获取私有属性，如果直接使用self.titleLabel会导致出现两个一样的标题控件 */
    id titleView    = [self valueForKey:@"_titleView"];
    
    CGSize titleSize    = CGSizeZero;
    if ([titleView isKindOfClass:[UILabel class]]) {
        titleSize   = [titleView sizeThatFits:CGSizeMake(FLT_MAX, FLT_MAX)];
    }
    
    titleSize   = CG_CGMinSize(tempLabelSize, titleSize);
    
    return titleSize;
}

- (CGRect)cg_calculateAreaWithContentType:(_CGButtonContentType)paramContentType contentRect:(CGRect)contentRect
{
    if (((contentRect.size.width - self.space) <= 0 || (contentRect.size.height - self.space) <= 0)) {
        return CGRectZero;
    }
    
    _isCalculateAreaButtonContentView   = YES;
    CGRect targetRect       = CGRectZero;
    CGFloat contentWidth    = CGRectGetWidth(contentRect);
    CGFloat contentHeight   = CGRectGetHeight(contentRect);
    
    CGSize imageSize        = [self cg_calculateImageSizeWithContentRect:contentRect];
    CGSize titleSize        = [self cg_calculateTitleSizeWithContentRect:contentRect imageSize:imageSize];
    
    CGPoint targetPoint = CGPointZero;
    CGSize targetSize   = CGSizeZero;
    
    if (paramContentType == _CGButtonContentTypeImageView) {
        targetSize  = imageSize;
    }else if (paramContentType == _CGButtonContentTypeTitleLabel) {
        targetSize  = titleSize;
    }
    
    if (self.buttonStyle == CGButtonStyleHorizonalLeft || self.buttonStyle == CGButtonStyleHorizonalRight) {
        
        CGFloat targetHeight;
        //获取指定视图的高度
        if (paramContentType == _CGButtonContentTypeImageView) {
            targetHeight    = imageSize.height;
        }else if (paramContentType == _CGButtonContentTypeTitleLabel) {
            targetHeight    = titleSize.height;
        }
        
        CGSize tempTargetSize   = CGSizeMake(titleSize.width + imageSize.width + self.space,  targetHeight);
        
        //获取标题+间距+图像的综合视图相对于ContentRect的起始坐标
        CGPoint contentPoint;
        
        contentPoint.x          = (contentWidth - tempTargetSize.width) / 2.0;
        
        switch (self.contentAlignment) {
            case CGButtonContentAlignmentTop:
            {
                contentPoint.y          = 0;
            }
                break;
            case CGButtonContentAlignmentBottom:
            {
                contentPoint.y          = contentHeight - targetHeight;
            }
                break;
            default:
            {
                contentPoint            = CG_CGCenterOriginWith(CGSizeMake(contentWidth, contentHeight), tempTargetSize);
            }
                break;
        }
        
        //获取综合视图相对于Button的起始坐标，
        targetPoint  = CGPointMake(CGRectGetMinX(contentRect) + contentPoint.x, CGRectGetMinY(contentRect) + contentPoint.y);
        
        if (self.buttonStyle == CGButtonStyleHorizonalLeft) {
            
            if (paramContentType == _CGButtonContentTypeImageView) {
                targetPoint.x   += self.space + titleSize.width;
            }
        }else {
            
            if (paramContentType == _CGButtonContentTypeTitleLabel) {
                targetPoint.x   += self.space + imageSize.width;
            }
        }
    }else {
        
        CGFloat targetWidth;
        //获取指定视图的宽度
        if (paramContentType == _CGButtonContentTypeImageView) {
            targetWidth     = imageSize.width;
        }else if (paramContentType == _CGButtonContentTypeTitleLabel) {
            targetWidth     = titleSize.width;
        }
        
        CGSize tempTargetSize   = CGSizeMake(targetWidth, titleSize.height + imageSize.height + self.space);
        
        //获取标题+间距+图像的综合视图相对于ContentRect的起始坐标
        CGPoint contentPoint;
        contentPoint.y  = (contentHeight - tempTargetSize.height) / 2.0;
        
        switch (self.contentAlignment) {
            case CGButtonContentAlignmentLeft:
            {
                contentPoint.x  = 0;
            }
                break;
            case CGButtonContentAlignmentRight:
            {
                contentPoint.x  = contentWidth - targetWidth;
            }
                break;
            default:
            {
                contentPoint = CG_CGCenterOriginWith(CGSizeMake(contentWidth, contentHeight),  tempTargetSize);
            }
                break;
        }
        
        //获取综合视图相对于Button的起始坐标，
        targetPoint  = CGPointMake(CGRectGetMinX(contentRect) + contentPoint.x, CGRectGetMinY(contentRect) + contentPoint.y);
        
        if (self.buttonStyle == CGButtonStyleVerticalTop) {
            
            if (paramContentType == _CGButtonContentTypeImageView) {
                targetPoint.y   += self.space + titleSize.height;
            }
        }else {
            
            if (paramContentType == _CGButtonContentTypeTitleLabel) {
                targetPoint.y   += self.space + imageSize.height;
            }
        }
    }
    
    targetRect = (CGRect){targetPoint, targetSize};
    
    _isCalculateAreaButtonContentView = NO;
    return targetRect;
}

#pragma mark - 重写系统布局方法
- (CGRect)contentRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(self.bounds, self.marginEdgeInsets);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (_isCalculateAreaButtonContentView) {
        return CGRectZero;
    }
    CGRect titleRect = [self cg_calculateAreaWithContentType:_CGButtonContentTypeTitleLabel contentRect:contentRect];
    CGInfoLog(@"title rect : %@", NSStringFromCGRect(titleRect));
    return titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (_isCalculateAreaButtonContentView) {
        return CGRectZero;
    }
    CGRect imageRect = [self cg_calculateAreaWithContentType:_CGButtonContentTypeImageView contentRect:contentRect];
    CGInfoLog(@"image rect : %@", NSStringFromCGRect(imageRect));
    return imageRect;
}

- (CGSize)sizeThatFits:(CGSize)paramSize
{
    //!!先使用imageView大小，在调用titleLabel大小，否则计算会出错，原因暂时没查
    CGSize imageSize = self.currentImage.size;
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeZero];
    
    CGSize size;
    
    if (self.buttonStyle == CGButtonStyleHorizonalLeft || self.buttonStyle == CGButtonStyleHorizonalRight) {
        size = CGSizeMake(titleSize.width + self.space + imageSize.width, MAX(titleSize.height, imageSize.height));
    }else {
        size = CGSizeMake(MAX(titleSize.width, imageSize.width), titleSize.height + self.space + imageSize.height);
    }
    
    size = CG_CGMaxSizeWidthSize(size, self.marginEdgeInsets);
    
    
    return size;
}

#pragma mark - 属性设置
- (void)setButtonStyle:(CGButtonStyle)buttonStyle
{
    if (buttonStyle != _buttonStyle) {
        _buttonStyle = buttonStyle;
        [self cg_updateButtonLayout];
    }
}

- (void)setSpace:(CGFloat)space
{
    if (space != _space) {
        _space = space;
        [self cg_updateButtonLayout];
    }
}

- (void)setMarginEdgeInsets:(UIEdgeInsets)marginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(marginEdgeInsets, _marginEdgeInsets)) {
        _marginEdgeInsets = marginEdgeInsets;
        [self cg_updateButtonLayout];
    }
}

- (void)setContentAlignment:(CGButtonContentAlignment)contentAlignment
{
    if (contentAlignment != _contentAlignment) {
        _contentAlignment   = contentAlignment;
        [self cg_updateButtonLayout];
    }
}

//- (void)setMaxSize:(CGSize)maxSize
//{
//    if (!CGSizeEqualToSize(maxSize, _maxSize)) {
//        _maxSize = maxSize;
//        [self cg_performAfterZeroDelaySelector:@selector(cg_updateButtonLayout)];
//    }
//}

@end
