//
//  NSObject+LoadLaunchImage.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/28.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSObject+LoadLaunchImage.h"

@implementation NSObject (LoadLaunchImage)

- (NSDictionary *)launchImageDictionary
{
    NSDictionary *launchImages = @{
                               NSStringFromCGSize(CGSizeMake(640, 960))     : @"LaunchImage@2x",
                               NSStringFromCGSize(CGSizeMake(640, 1136))    : @"LaunchImage-568h@2x",
                               NSStringFromCGSize(CGSizeMake(750, 1334))    : @"LaunchImage-800-667h@2x",
                               NSStringFromCGSize(CGSizeMake(768, 1024))    : @"LaunchImage-Portrait~ipad",
                               NSStringFromCGSize(CGSizeMake(1242, 2208))   : @"LaunchImage-800-Portrait-736h@3x",
                               NSStringFromCGSize(CGSizeMake(1536, 2048))   : @"LaunchImage-700-Portrait@2x~ipad",
                               };
    return launchImages;
}

- (UIImage *)cg_load_type_fixedResource_CurrentPixelsImageWithErrorType:(CGLoadLaunchImageErrorType *)errorType
{
    UIScreenMode *screenMode = [UIScreen mainScreen].currentMode;
    NSString *pixelsKey = NSStringFromCGSize(screenMode.size);
    
    NSDictionary *launchImageDic = self.launchImageDictionary;
    
    if (![launchImageDic.allKeys containsObject:pixelsKey]) {
        *errorType = CGLoadLaunchImageErrorTypeNullKey;
    }
    
    NSString *launchImageName = [launchImageDic objectForKey:NSStringFromCGSize(screenMode.size)];
    UIImage *launchImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:launchImageName ofType:@"png"]];
    if (launchImage == nil) {
        *errorType = CGLoadLaunchImageErrorTypeNullImage;
    }
    
    return launchImage;
}

////////////////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////

- (UIImage *)cg_load_type_enumImagesResource_CurrentPixelsImageWithEorrType:(CGLoadLaunchImageErrorType *)errorType
{
    UIScreenMode *screenMode = [UIScreen mainScreen].currentMode;
    
    CGSize sizeForScreenMode = screenMode.size;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *arr = [bundle pathsForResourcesOfType:@"png" inDirectory:nil];
//    NSLog(@"images:%@", arr);

    if (arr.count) {
        *errorType = CGLoadLaunchImageErrorTypeDefaultImagePathNullImage;
    }
    __block UIImage *launchImage = nil;
    __block CGSize launchImageSize;

    [arr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {

        NSString *imagePath = [obj lastPathComponent];
        if ([imagePath hasPrefix:@"LaunchImage"]) {
            UIImage *tmpLaunchImage = [UIImage imageWithContentsOfFile:obj];
            if (tmpLaunchImage) {

                CGSize tmpImageSize = tmpLaunchImage.size;
                launchImageSize = CGSizeMake(tmpImageSize.width * tmpLaunchImage.scale, tmpImageSize.height * tmpLaunchImage.scale);
                if (CGSizeEqualToSize(launchImageSize, sizeForScreenMode)) {
                    launchImage = tmpLaunchImage;
                    
                    *stop = YES;
                }
//                NSLog(@"imageName:%@,  imageSize::%@,  scale::%f,  size::%@", imagePath, NSStringFromCGSize(tmpImageSize), tmpLaunchImage.scale, NSStringFromCGSize(launchImageSize));
            }
        }
    }];
    
    if (launchImage == nil) {
        *errorType = CGLoadLaunchImageErrorTypeNullImage;
    }
    
    return launchImage;
}
@end
