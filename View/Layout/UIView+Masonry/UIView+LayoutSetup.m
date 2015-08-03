//
//  UIView+LayoutSetup.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/31.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+LayoutSetup.h"
#import "Masonry.h"

@implementation UIView (LayoutSetup)

- (void)setupConstraintsWithType:(CGViewLayoutType)type
{
    [self setupConstraintsWithType:type space:0];
}

- (void)setupConstraintsWithType:(CGViewLayoutType)type space:(CGFloat)space
{
    if (self.subviews.count <= 1) {
        NSAssert(nil, @"子视图暂时必须大于2");
    }
    
    //获取第一个子视图
    UIView *firstSubview = self.subviews[0];
    
    [firstSubview mas_makeConstraints:^(MASConstraintMaker *make) {
        [self setupMakeConstranints:make type:type space:space];
    }];
}

- (void)setupMakeConstranints:(MASConstraintMaker *)make type:(CGViewLayoutType)type space:(CGFloat)space
{
    //设置子视图中第一个
    NSInteger startIndex = 1;
    
    //将其他子视图添加到数组中
    NSArray *subview = [self.subviews subarrayWithRange:NSMakeRange(startIndex, self.subviews.count - startIndex)];
    
    if (type & CGViewLayoutTypeEqualWidth) {
        
        if ((NSInteger)space == 0) {
            make.width.equalTo(subview);
        }else {
            make.width.equalTo(subview).offset(space);
        }
    }
    
    if (type & CGViewLayoutTypeEqualHeight) {
        
        if ((NSInteger)space == 0) {
            make.height.equalTo(subview);
        }else {
            make.height.equalTo(subview).offset(space);
        }
    }
    
    if (type & CGViewLayoutTypeEqualTop) {
        
        make.top.equalTo(subview).offset(space);
    }
    
    if (type & CGViewLayoutTypeEqualLeading) {
        
        make.leading.equalTo(subview).offset(space);
    }
    
    if (type & CGViewLayoutTypeEqualBottom) {
        
        make.bottom.equalTo(subview).offset(space);
    }
    
    if (type & CGViewLayoutTypeEqualTrailing) {
        
        make.trailing.equalTo(subview).offset(space);
    }
}

//- (void)setupSubviewConstraintsWithHorizontalSpace:(CGFloat)space
//{
//    
//}
//
//- (void)setupSubviewConstraintsWithVerticalSpace:(CGFloat)space
//{
//    
//}

- (void)setupMarginSpace:(UIEdgeInsets)marginSpace type:(CGLayoutType)type subviewSpace:(CGFloat)subviewSpace
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[UIView class]]) {
            UIView *subview = obj;
            
            //是否是第一个视图
            BOOL isFirstView = (idx == 0);
            
            //是否是最后一个视图
            BOOL isLastView = (idx == self.subviews.count - 1);
            
            //上一个视图
            UIView *previousView = nil;
            
            if (isFirstView && isLastView) {
                //当只有一个子视图时
                [subview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self).insets(marginSpace);
                }];
            }else {
                //多个子视图时
                if (isFirstView) {
                    //第一个子视图
                    [subview mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(self.mas_top).offset(marginSpace.top);
                        make.leading.equalTo(self.mas_leading).offset(marginSpace.left);
                        make.bottom.equalTo(self.mas_bottom).offset(marginSpace.bottom);
                        
                        //设置第一个子视图与其他子视图之间的 top 与 bottom 值相等
                        NSArray *otherSubviews = [self.subviews subarrayWithRange:NSMakeRange(1, self.subviews.count - 1)];
                        make.top.equalTo(otherSubviews);
                        make.bottom.equalTo(otherSubviews);
                    }];
                }else if (isLastView) {
                    //最后一个子视图
                    
                    //上一个视图
                    previousView = self.subviews[idx - 1];
                    
                    [subview mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.trailing.equalTo(self.mas_trailing).offset(-marginSpace.right);
                        make.leading.equalTo(previousView.mas_trailing).offset(subviewSpace);
                    }];
                }else {
                    //中间子视图
                    
                    //上一个视图
                    previousView = self.subviews[idx - 1];
                    
                    [subview mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.leading.equalTo(previousView.mas_trailing).offset(subviewSpace);
                    }];
                }
            }
        }
        
    }];
}
@end
