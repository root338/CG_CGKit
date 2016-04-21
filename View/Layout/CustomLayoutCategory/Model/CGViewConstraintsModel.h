//
//  CGViewConstraintsModel.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

NS_ASSUME_NONNULL_BEGIN
/** uiview 设置的约束 */
@interface CGViewConstraintsModel : CGBaseObject

@property (nullable, nonatomic, strong) NSLayoutConstraint *fixedWidth;
@property (nullable, nonatomic, strong) NSLayoutConstraint *fixedHeight;

/** 
 *  其他相关约束 
 *  @param key：
 */
@property (nullable, nonatomic, strong) NSDictionary<NSString *, NSArray<NSLayoutConstraint *> *> *constraints;

@end
NS_ASSUME_NONNULL_END