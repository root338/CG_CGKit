//
//  UIView+DrawLine.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/15.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, DDrawLineType) {
    
    DDrawLineTypeNone    = 0,
    DDrawLineTypeTop     = 1 << 0,
    DDrawLineTypeLeft    = 1 << 1,
    DDrawLineTypeBottom  = 1 << 2,
    DDrawLineTypeRight   = 1 << 3,
    DDrawLineTypeAll     = DDrawLineTypeTop | DDrawLineTypeLeft | DDrawLineTypeBottom | DDrawLineTypeRight,
};

/**
 *  创建绘制边框的对象
 */
@interface UIView (DrawBoxLine)

/**
 *  边框的宽度
 */
@property (strong, nonatomic) NSNumber *lineWidth;

/**
 *  边框的颜色
 */
@property (strong, nonatomic) UIColor *lineColor;

/**
 *  创建绘制对象
 *
 *  @param type       绘制边框的类型
 *  @param edgeInsets 边框距离顶点的距离
 *
 *  @return 返回创建好的绘图对象
 */
- (UIBezierPath *)createBoxType:(DDrawLineType)type edge:(UIEdgeInsets)edgeInsets;

//- (void)drawRect:(CGRect)rect;
@end
