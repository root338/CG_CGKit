//
//  UIImage+CGLaunchImage.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/28.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIImage+CGLaunchImage.h"
#import "NSBundle+GetAppInfo.h"

#import "CGVerifyIOSVersionHeader.h"

@implementation UIImage (CGLaunchImage)

+ (UIImage *)cg_currentLaunchImage
{
    UIImage *currentLaunchImage = nil;
    
    NSArray *launchImages = [NSBundle getLaunchImages];
    
    //判断设备横屏、竖屏
    
    UIInterfaceOrientation portrait = [[UIApplication sharedApplication] statusBarOrientation];
    NSString *launchImageOrientation;
    if (portrait == UIInterfaceOrientationPortrait || portrait == UIInterfaceOrientationPortraitUpsideDown) {
        launchImageOrientation = @"Portrait";
    }else if (portrait == UIInterfaceOrientationLandscapeLeft || portrait == UIInterfaceOrientationLandscapeRight) {
        launchImageOrientation = @"Landscape";
    }
    
    //获取屏幕大小
    CGSize windowsSize = [UIScreen mainScreen].bounds.size;
    
    __block NSString *launchImageName   = nil;
    [launchImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            if ([[obj objectForKey:@"UILaunchImageMinimumOSVersion"] floatValue] <= _CG_IOS_CURRENTVERIOS) {
                
                if ([launchImageOrientation isEqualToString:[obj objectForKey:@"UILaunchImageOrientation"]]) {
                    
                    CGSize imageSize = CGSizeFromString([obj objectForKey:@"UILaunchImageSize"]);
                    
                    if (CGSizeEqualToSize(windowsSize, imageSize)) {
                        launchImageName = [obj objectForKey:@"UILaunchImageName"];
                        *stop = YES;
                    }
                }
                
            }
        }
    }];
    
    if (launchImageName) {
        currentLaunchImage = [UIImage imageNamed:launchImageName];
    }
    
    return currentLaunchImage;
}
@end
