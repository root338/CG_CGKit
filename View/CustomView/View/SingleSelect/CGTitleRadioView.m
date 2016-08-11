//
//  CGTitleRadioView.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleRadioView.h"

#import "CGRadioView.h"

#import "CGTitleRadioCollectionViewCell.h"

@interface CGTitleRadioView ()<CGRadioViewDataSource, CGRadioViewDelegate>
{
    NSArray                 *_titles;
    CGRadioViewAppearance   *_appearance;
}
@property (nonatomic, strong) CGRadioView *radioView;

@end

@implementation CGTitleRadioView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles appearance:(nonnull CGRadioViewAppearance *)appearance
{
    CGRect frame  = CGRectZero;
    self    = [super initWithFrame:frame];
    if (self) {
        _titles = titles;
        
        _radioView  = [[CGRadioView alloc] initWithFrame:frame appearance:appearance];
        _radioView.dataSource   = self;
        _radioView.delegate     = self;
        _appearance = appearance;
    }
    return self;
}

#pragma mark - CGRadioViewDataSource
- (NSInteger)numberOfTitleInRadioView:(CGRadioView *)radioView
{
    return _titles.count;
}

- (UICollectionViewCell *)radioView:(CGRadioView *)radioView cellForIndexPath:(NSIndexPath *)indexPath
{
    CGTitleRadioCollectionViewCell *cell = [radioView dequeueReusableCellWithReuseIdentifierClass:[CGTitleRadioCollectionViewCell class] forIndexPath:indexPath];
    
    [cell setupCollectionViewCellContentWithData:_appearance];
    
    return cell;
}

@end
