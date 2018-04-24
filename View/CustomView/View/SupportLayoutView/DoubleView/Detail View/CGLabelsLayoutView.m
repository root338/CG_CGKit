//
//  CGLabelsLayoutView.m
//  QuickAskCommunity
//
//  Created by apple on 2018/4/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "CGLabelsLayoutView.h"

@interface CGLabelsLayoutView ()

@property (nonatomic, strong, readwrite) UILabel *firstLabel;
@property (nonatomic, strong, readwrite) UILabel *secondLabel;

@end

@implementation CGLabelsLayoutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _firstLabel = [[UILabel alloc] init];
        _secondLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_firstLabel];
        [self.contentView addSubview:_secondLabel];
    }
    
    return self;
}

#pragma mark - CGDoubleLayoutDelegate
- (UIView *)cg_layoutFirstTargetView
{
    return self.firstLabel;
}

- (UIView *)cg_layoutSecondTargetView
{
    return self.secondLabel;
}

@end
