//
//  CGBrowsePhotoViewController.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleBarViewController.h"

NS_ASSUME_NONNULL_BEGIN

/** 图片浏览视图 */
@interface CGBrowsePhotoViewController : CGTitleBarViewController

/** 图片数据 */
@property (nullable, nonatomic, strong) NSArray *browsePhotoDataSource;

/** 开始观看的位置 */
@property (nonatomic, assign) NSInteger startIndex;

@end

NS_ASSUME_NONNULL_END