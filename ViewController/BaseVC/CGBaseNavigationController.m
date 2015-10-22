//
//  CGBaseNavigationViewController.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseNavigationController.h"
#import "CGBaseNavigationControllerDelegate.h"

@interface CGBaseNavigationController ()

@end

@implementation CGBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController<CGBaseNavigationControllerDelegate> *)viewController animated:(BOOL)animated
{
    BOOL isShouldAnimated = self.preferredNavigationBarAnimation;
    BOOL isShouldHide = self.preferredNavigationBarHidden;
    if ([viewController respondsToSelector:@selector(hideNavigationBarWithNavigationController:)]) {
        isShouldHide = [(UIViewController<CGBaseNavigationControllerDelegate> *)viewController hideNavigationBarWithNavigationController:navigationController];
    }
    
    if (isShouldHide != self.navigationBarHidden) {
        [self setNavigationBarHidden:isShouldHide animated:isShouldAnimated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
