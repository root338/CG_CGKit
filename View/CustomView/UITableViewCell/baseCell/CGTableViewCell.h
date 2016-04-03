//
//  CGTableViewCell.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGViewProtocol.h"

@protocol CGTableViewCellDelegate <NSObject>

@optional
- (void)setupTableViewCellContentWithData:(id)paramData;

@end

@interface CGTableViewCell : UITableViewCell<CGTableViewCellDelegate, CGViewInitializationProtocol>



@end
