//
//  CGPhotoListViewController.h
//  TestCG_CGKit
//
//  Created by DY on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController.h"

/** 照片浏览列表 */
@interface CGPhotoListViewController : CGBaseViewController

/** 选择照片的最大数 默认为 1 */
@property (nonatomic, assign) NSInteger selectedMaxNumber;
/** 选择照片的最小数 默认为 1 */
@property (nonatomic, assign) NSInteger selectedMinNumber;

@end
