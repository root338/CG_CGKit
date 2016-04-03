//
//  CGCollectionViewCell.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGCollectionViewCellDelegate <NSObject>

@optional
- (void)setupCollectionViewCellContentWithData:(id)paramData;

@end

@interface CGCollectionViewCell : UICollectionViewCell<CGCollectionViewCellDelegate>

@end
