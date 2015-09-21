//
//  NSObject+JudgePurview.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSObject+JudgePurview.h"

#import <AssetsLibrary/AssetsLibrary.h>

@implementation NSObject (JudgePurview)

- (BOOL)cg_verifyIsAccessAssetsLibrary
{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

@end
