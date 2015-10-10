//
//  NSString+InteractivePopEnable.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/9.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIViewController+InteractivePopEnable.h"

@implementation UIViewController (InteractivePopEnable)

-(void) baseInteractivePopGestureRecognizerEnable:(BOOL) enable
{
    NSLog(@"%@", self.navigationController);
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (enable) {
//            self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }else{
            
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        
//    }
}

@end
