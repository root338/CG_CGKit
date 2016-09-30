//
//  CGButton.m
//  QuickAskCommunity
//
//  Created by DY on 16/1/15.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGButton.h"

#import "Value+Constant.h"
#import "UIView+CGSetupFrame.h"
#import "UIButton+UpdateLocate.h"
#import "UIView+CG_CGAreaCalculate.h"
#import "UIButton+CGCreateCustomButton.h"

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
    
    UIFont          *_defaultAttributedDictIdentifier;
    NSDictionary    *_defaultAttributedDict;
}

@property (nonatomic, strong) UILabel *tempCalculateLabel;

@end

@implementation CGButton

- (void)initialization
{
    _contentSubviewOfficeSpace  = 0;
    _space                      = 0;
    _marginEdgeInsets           = UIEdgeInsetsZero;
    _imageViewSize              = CGSizeZero;
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
    
    if (![titleView isKindOfClass:[UILabel class]]) {
        //当使用setTitle:forState:方法设置标题时，button不会立即刷新，当立即重新刷新button大小时，会出错
        titleView   = nil;
    }
    CGSize titleSize    = [self calculateCurrentTitleAreaWithTitleLabel:titleView];
    
    titleSize   = CG_CGMinSize(tempLabelSize, titleSize);
    
    return titleSize;
}

- (CGPoint)calculateContentPointWithContentSize:(CGSize)contentSize targetContentSize:(CGSize)targetContentSize
{
    CGPoint contentPoint    = CGPointZero;
    CGFloat contentWidth    = contentSize.width;
    CGFloat contentHeight   = contentSize.height;
    
    switch (self.contentHorizontalAlignment) {
            
        case UIControlContentHorizontalAlignmentLeft:
            contentPoint.x  = 0;
            break;
        case UIControlContentHorizontalAlignmentRight:
            contentPoint.x  = contentWidth - targetContentSize.width;
            break;
        default:
            contentPoint.x  = CG_CGCenterOriginX(targetContentSize.width, contentWidth);
            break;
    }
    
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            contentPoint.y  = 0;
            break;
        case UIControlContentVerticalAlignmentBottom:
            contentPoint.y  = contentHeight - targetContentSize.height;
            break;
        default:
            contentPoint.y  = CG_CGCenterOriginY(targetContentSize.height, contentHeight);
            break;
    }
    return contentPoint;
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
        
        CGFloat targetHeight        = 0.0;   //当前控件的高度
        CGFloat maxContentHeight    = MAX(imageSize.height, titleSize.height);
        CGFloat offset              = 0;
        
        //获取指定视图的高度
        if (paramContentType == _CGButtonContentTypeImageView) {
            targetHeight    = imageSize.height;
            if (imageSize.height < titleSize.height) {
                offset  = self.contentSubviewOfficeSpace;
            }
        }else if (paramContentType == _CGButtonContentTypeTitleLabel) {
            targetHeight    = titleSize.height;
            if (titleSize.height < imageSize.height) {
                offset  = self.contentSubviewOfficeSpace;
            }
        }
        
        CGSize tempTargetSize   = CGSizeMake(titleSize.width + imageSize.width + self.space,  maxContentHeight);
        
        //获取标题+间距+图像的综合视图相对于ContentRect的起始坐标
        CGPoint contentPoint    = [self calculateContentPointWithContentSize:CGSizeMake(contentWidth, contentHeight) targetContentSize:tempTargetSize];
        
        CGFloat originTargetY   = 0;
        switch (self.contentSubviewAlignment) {
            case CGButtonContentAlignmentTop:
            {
                originTargetY   = offset;
            }
                break;
            case CGButtonContentAlignmentBottom:
            {
                originTargetY   = maxContentHeight - targetHeight - offset;
            }
                break;
            default:
            {
                originTargetY   = CG_CGCenterOriginY(targetHeight, maxContentHeight);
            }
                break;
        }
        
        //获取综合视图相对于Button的起始坐标，
        targetPoint  = CGPointMake(CGRectGetMinX(contentRect) + contentPoint.x, CGRectGetMinY(contentRect) + contentPoint.y + originTargetY);
        
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
        
        CGFloat targetWidth     = 0.0;
        CGFloat maxContentWidth = MAX(imageSize.width, titleSize.width);
        CGFloat offset          = 0;
        
        //获取指定视图的宽度
        if (paramContentType == _CGButtonContentTypeImageView) {
            targetWidth     = imageSize.width;
            if (imageSize.width < titleSize.width) {
                offset  = self.contentSubviewOfficeSpace;
            }
        }else if (paramContentType == _CGButtonContentTypeTitleLabel) {
            targetWidth     = titleSize.width;
            if (titleSize.width < imageSize.width) {
                offset = self.contentSubviewOfficeSpace;
            }
        }
        
        CGSize tempTargetSize   = CGSizeMake(maxContentWidth, titleSize.height + imageSize.height + self.space);
        
        //获取标题+间距+图像的综合视图相对于ContentRect的起始坐标
        CGPoint contentPoint    = [self calculateContentPointWithContentSize:CGSizeMake(contentWidth, contentHeight) targetContentSize:tempTargetSize];
        
        CGFloat originTargetX   = 0;
        switch (self.contentSubviewAlignment) {
            case CGButtonContentAlignmentLeft:
            {
                originTargetX   = offset;
            }
                break;
            case CGButtonContentAlignmentRight:
            {
                originTargetX   = maxContentWidth - targetWidth - offset;
            }
                break;
            default:
            {
                originTargetX   = CG_CGCenterOriginX(targetWidth, maxContentWidth);
            }
                break;
        }
        
        //获取综合视图相对于Button的起始坐标，
        targetPoint  = CGPointMake(CGRectGetMinX(contentRect) + contentPoint.x + originTargetX, CGRectGetMinY(contentRect) + contentPoint.y);
        
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
    CGSize imageSize = CGSizeZero;
    if (!CGSizeEqualToSize(self.imageViewSize, CGSizeZero)) {
        imageSize   = self.imageViewSize;
    }else {
        imageSize   = self.currentImage.size;
    }
    
    //当使用setTitle:forState:方法设置标题时，button不会立即刷新，当立即重新刷新button大小时，会使用原标题进行计算出错
    CGSize titleSize    = [self calculateCurrentTitleAreaWithTitleLabel:self.titleLabel];
    
    CGSize size;
    
    if (self.buttonStyle == CGButtonStyleHorizonalLeft || self.buttonStyle == CGButtonStyleHorizonalRight) {
        size = CGSizeMake(titleSize.width + self.space + imageSize.width, MAX(titleSize.height, imageSize.height));
    }else {
        size = CGSizeMake(MAX(titleSize.width, imageSize.width), titleSize.height + self.space + imageSize.height);
    }
    
    size = CG_CGMaxSizeWidthSize(size, self.marginEdgeInsets);
    
    if (paramSize.width > CGZeroFloatValue && paramSize.width < size.width) {
        size.width  = paramSize.width;
    }
    if (paramSize.height > CGZeroFloatValue && paramSize.height < size.height) {
        size.height = paramSize.height;
    }
    return size;
}

- (CGSize)calculateCurrentTitleAreaWithTitleLabel:(UILabel *)titleLabel
{
    CGSize titleSize        = CGSizeZero;
    CGSize compressedSize   = CGSizeMake(FLT_MAX, FLT_MAX);
    if (self.currentAttributedTitle) {
        
        if (titleLabel) {
            [titleLabel setAttributedText:self.currentAttributedTitle];
            titleSize   = [titleLabel sizeThatFits:compressedSize];
        }else {
            titleSize           = [self.currentAttributedTitle size];
        }
    }else {
        
        if (titleLabel) {
            [titleLabel setText:self.currentTitle];
            //iOS7 下如果不设置会导致按钮颜色变为默认的蓝色
            [titleLabel setTextColor:self.currentTitleColor];
            titleSize   = [titleLabel sizeThatFits:compressedSize];
        }else {
            
            if (_defaultAttributedDictIdentifier != self.titleLabel.font) {
                _defaultAttributedDict  = nil;
            }
            if (_defaultAttributedDict == nil) {
                
                UIFont *titleFont       = self.titleLabel.font;
                if (!titleFont) {
                    titleFont   = [UIFont systemFontOfSize:15];
                }
                _defaultAttributedDict  = @{
                                            NSFontAttributeName : titleFont,
                                            NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle],
                                            };
                _defaultAttributedDictIdentifier    = titleFont;
            }
            
            titleSize   = [self.currentTitle sizeWithAttributes:_defaultAttributedDict];
        }
    }
    
    if (!titleLabel) {
        //单纯使用富文本进行计算，与Label的 sizeThatFits: 方法计算会出现稍微的偏差，从而导致内容显示不全
        titleSize.width     = ceil(titleSize.width);
        titleSize.height    = ceil(titleSize.height);
    }
    
    return titleSize;
}

//#pragma mark - 约束系统方法重写

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

- (void)setContentSubviewAlignment:(CGButtonContentAlignment)contentSubviewAlignment
{
    if (contentSubviewAlignment != _contentSubviewAlignment) {
        _contentSubviewAlignment   = contentSubviewAlignment;
        [self cg_updateButtonLayout];
    }
}

- (void)setContentSubviewOfficeSpace:(CGFloat)contentSubviewOfficeSpace
{
    if (_contentSubviewOfficeSpace != contentSubviewOfficeSpace) {
        
        _contentSubviewOfficeSpace  = contentSubviewOfficeSpace;
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

@implementation CGButton (CGCreateButton)

+ (CGButton *)createButtonWithType:(UIButtonType)buttonType style:(CGButtonStyle)buttonStyle space:(CGFloat)space title:(NSString *)title font:(nullable UIFont *)font titleColor:(nullable UIColor *)titleColor image:(nullable UIImage *)image
{
    CGButton *button    = [self cg_createButtonWithButtonType:buttonType title:title titleColor:titleColor font:font normalImage:image];
    button.buttonStyle  = buttonStyle;
    button.space        = space;
    return button;
}

@end
