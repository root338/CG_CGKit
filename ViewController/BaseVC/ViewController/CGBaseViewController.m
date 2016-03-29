//
//  CGBaseViewController.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/29.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseViewController.h"

@interface CGBaseViewController ()

@end

@implementation CGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGPrintClassNameLog()
    
    if (!self.navigationController.navigationBarHidden) {
        
        UIBarButtonItem *rightItem  = nil;
        id target   = self;
        SEL action  = @selector(handleRightItemAction:);
        
        if (self.rightItemImage) {
            rightItem   = [[UIBarButtonItem alloc] initWithImage:self.rightItemImage landscapeImagePhone:self.landscapeImage ? self.landscapeImage : self.rightItemImage style:UIBarButtonItemStylePlain target:target action:action];
        }else if (self.rightItemTitle) {
            rightItem   = [[UIBarButtonItem alloc] initWithTitle:self.rightItemTitle style:UIBarButtonItemStylePlain target:target action:action];
        }
        
        self.navigationItem.rightBarButtonItem  = rightItem;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleRightItemAction:(id)sender
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

- (void)dealloc
{
    CGPrintClassNameLog()
}

@end
