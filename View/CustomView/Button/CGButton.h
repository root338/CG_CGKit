//
//  CGButton.h
//  QuickAskCommunity
//
//  Created by DY on 16/1/15.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseButton.h"
#import "CGButtonAlignStyleHeader.h"

NS_ASSUME_NONNULL_BEGIN

/** 处理按钮当前内容时的方式，使用期间：计算按钮显示区域的时候 */
typedef NS_ENUM(NSInteger, CGButtonHandleCurrentContentType) {
    /** 空 */
    CGButtonHandleCurrentContentTypeNone,
    /** 默认的处理方法，当优先获取的值不存在时，获取次级内容项 */
    CGButtonHandleCurrentContentTypeDefalut,
    
};

/**
 *  重写UIButton布局的子类，方便图像和标题的布局
 *  @param UIButton 的子类
 *  @param 功能：  1. 方便设置图像和标题的对齐样式，图像和标题之间的间距，外边界的间距
 *
 */
@interface CGButton : CGBaseButton

#pragma mark - 标题、图片布局设置
/** 图片标题的对齐方式 */
@property (nonatomic, assign) CGButtonStyle buttonStyle;
/** 图片标题之间的间距 */
@property (nonatomic, assign) CGFloat space;
/** 可设置的最大大小 */
//@property (nonatomic, assign) CGSize maxSize;
/** contentView距离外边框之间的间距 */
@property (nonatomic, assign) UIEdgeInsets marginEdgeInsets;
/** 标题和图片的对齐方式 */
@property (nonatomic, assign) CGButtonContentAlignment contentSubviewAlignment;
/** 标题和图片对齐方式时的偏移间距 */
@property (nonatomic, assign) CGFloat contentSubviewOfficeSpace;

//@property (nonatomic, assign) UIControlContentHorizontalAlignment   contentViewHorizontalAlignment;
//@property (nonatomic, assign) UIControlContentVerticalAlignment     contentViewVerticalAlignment;
//@property (nonatomic, assign) UIOffset imageViewOffset;

/** 指定imageView的大小 @warning 当图片不存在时也会占据显示区域 */
@property (nonatomic, assign) CGSize imageViewSize;

/** 标题的最大宽度 @param sizeToFit下控制titleLabel的显示区域 */
@property (nonatomic, assign) CGFloat titleLabelMaxWidth;

/**
 添加设置handleCurrentContentType, setupCurrentTitleContent, setupCurrentImage 的原因，当按钮不同状态下标题或图片不相同时，在刷新内容时当前的按钮状态有可能会是多个状态的集值，随后变为最终状态后有可能导致显示区域计算错误，所以在此添加这两个block以帮助计算的实现
 可能的例子情况：按钮仅在selected状态下才有图片 在UIControlEventTouchUpInside事件中，处理按钮为选中，这时按钮的状态为5，即选中，高亮都为YES，这时获取的当前图片为nil，而随后变为YES后会导致计算的大小出错
 */

@property (nonatomic, assign, readwrite) CGButtonHandleCurrentContentType handleCurrentContentType;

/** 设置当前标题，返回类型应为NSAttributedString或NSString */
@property (nullable, nonatomic, copy) __nullable id (^setupCurrentTitleContent) (__kindof CGButton * button, UIControlState currentState);
/** 设置当前图片 */
@property (nullable, nonatomic, copy) UIImage  * _Nullable  (^setupCurrentImage) (__kindof CGButton * button, UIControlState currentState);



@property (nullable, nonatomic, weak) NSLayoutConstraint *heightConstraint;
@property (nullable, nonatomic, weak) NSLayoutConstraint *widthConstraint;

- (CGSize)sizeThatFits:(CGSize)size;

@end

@interface CGButton (CGCreateButton)

+ (__kindof CGButton *)createButtonWithType:(UIButtonType)buttonType style:(CGButtonStyle)buttonStyle space:(CGFloat)space title:(nullable NSString *)title font:(nullable UIFont *)font titleColor:(nullable UIColor *)titleColor image:(nullable UIImage *)image;

@end

NS_ASSUME_NONNULL_END
