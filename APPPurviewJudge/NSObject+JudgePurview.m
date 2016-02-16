//
//  NSObject+JudgePurview.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSObject+JudgePurview.h"


#import <AssetsLibrary/AssetsLibrary.h>

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@implementation NSObject (JudgePurview)

- (BOOL)cg_verifyIsAccessAssetsLibrary
{
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

- (BOOL)cg_verifyIsCamera
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

@end
