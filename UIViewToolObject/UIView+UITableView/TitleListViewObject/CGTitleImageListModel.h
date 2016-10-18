//
//  CGTitleImageListModel.h
//  QuickAskCommunity
//
//  Created by DY on 2016/10/18.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

/** CGTitleListView 类下可用的直接类 */
@interface CGTitleImageListModel : CGBaseObject

@property (nullable, nonatomic, strong) NSString *title;

@property (nullable, nonatomic, strong) UIImage *image;

//
//@property (nullable, nonatomic, strong) NSString *imagePath;

@end

NS_ASSUME_NONNULL_END
