//
//  CGBaseTableView.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGViewProtocol.h"
#import "UITableView+CGRegisterCell.h"

@interface CGTableView : UITableView

/** 
 *  隐藏plainStyle 模式下没有数据时还会显示的线条
 *  实现原理为TableView添加一个空白的footerView，当取消时需要注意没有自动添加的UIView，防止取消了自定义的添加视图
 */
@property (nonatomic, assign) BOOL isHideOverLineForPlainStyle;


@end
