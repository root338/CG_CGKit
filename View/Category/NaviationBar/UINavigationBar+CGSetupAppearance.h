//
//  UINavigationBar+CGSetupAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 2017/2/23.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CGNavigationBarAppearanceType) {
    
    CGNavigationBarAppearanceTypeDefault,
    CGNavigationBarAppearanceTypeClear,
};


@interface UINavigationBar (CGSetupAppearance)

@property (nonatomic, assign) CGNavigationBarAppearanceType navigationBarAppearanceType;

- (void)removeAllCahceNavigationBarAppearanceType;
@end

NS_ASSUME_NONNULL_END
