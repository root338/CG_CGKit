//
//  CGTitleRadioView.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGRadioViewAppearance;

@interface CGTitleRadioView : CGBaseView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles appearance:(CGRadioViewAppearance *)appearance;


@end

NS_ASSUME_NONNULL_END