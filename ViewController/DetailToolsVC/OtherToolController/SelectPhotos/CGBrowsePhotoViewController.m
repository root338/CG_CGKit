//
//  CGBrowsePhotoViewController.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBrowsePhotoViewController.h"

#import "CGCollectionView.h"
#import "CGBrowsePhotoCollectionViewCell.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CGAddConstraints.h"
#import "UIScrollView+CGProperty.h"
#import "CGNavigationAppearanceProtocol.h"

#import "CGCollectionViewDataSourceManager.h"
#import "CGBrowseImageCollectionViewFlowLayout.h"

@interface CGBrowsePhotoViewController ()
<
    UICollectionViewDelegate,
    CGNavigationAppearanceProtocol,
    UIGestureRecognizerDelegate
>
{
    
}
@property (nonatomic, strong) CGCollectionView *browsePhotoCollectionView;
@property (nonatomic, strong) CGCollectionViewDataSourceManager *dataSourceManager;
@end

@implementation CGBrowsePhotoViewController

- (BOOL)prefersStatusBarHidden
{
    return self.isNavigationBarHidden;
}

#pragma mark - 事件

- (void)handleTopAction:(UITapGestureRecognizer *)tapGestureRecognizer
{
    BOOL isHidden   = !self.navigationBar.hidden;
    [self setNavigationBarHidden:isHidden animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cg_setupBrowsePhotoListView];
    
//    UITapGestureRecognizer *tapGestureRecognizer    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTopAction:)];
//    tapGestureRecognizer.numberOfTapsRequired       = 1;
//    tapGestureRecognizer.delegate   = self;
//    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cg_setupBrowsePhotoListView
{
    
    CGBrowseImageCollectionViewFlowLayout *flowLayout = [[CGBrowseImageCollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize                 = self.view.bounds.size;
    flowLayout.minimumLineSpacing       = 30;
    flowLayout.scrollDirection          = UICollectionViewScrollDirectionHorizontal;
    
    _browsePhotoCollectionView  = [[CGCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _browsePhotoCollectionView.showsHorizontalScrollIndicator   = NO;
    
    [self.view addSubview:_browsePhotoCollectionView];
    [_browsePhotoCollectionView cg_autoEdgesInsetsZeroToSuperview];
    
    Class registerCollectionCellClassName   = [CGBrowsePhotoCollectionViewCell class];
    [_browsePhotoCollectionView cg_registerReuseClass:registerCollectionCellClassName];
    
    _dataSourceManager  = [[CGCollectionViewDataSourceManager alloc] initWithDataSource:self.browsePhotoDataSource cellIdentifierForClass:registerCollectionCellClassName setupCellBlock:^(UICollectionView * _Nonnull collectionView, __kindof CGBrowsePhotoCollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
        
        [cell setupCollectionViewCellContentWithData:data];
    }];
    
    _browsePhotoCollectionView.dataSource   = _dataSourceManager;
    _browsePhotoCollectionView.delegate     = self;
    
    if (self.startIndex >= self.browsePhotoDataSource.count) {
        //判断开始索引是否符合要求
        self.startIndex = 0;
    }
    
    if (self.startIndex) {
        [_browsePhotoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.startIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    [self setupTitleWithPage:self.startIndex + 1];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setupTitleWithPage:[scrollView cg_calculateScrollPageWithScale:0.5]];
}

- (void)setupTitleWithPage:(NSInteger)page
{
    if (page < 1 || page > self.browsePhotoDataSource.count) {
        CGErrorLog(@"现在的索引为%li 索引应 大于0 小于%li", (long)page, self.browsePhotoDataSource.count);
        return ;
    }
    
    self.title  = [NSString stringWithFormat:@"%li/%lu", page, self.browsePhotoDataSource.count];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (self.isNavigationBarHidden) {
        return YES;
    }else {
        
        if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
            
        }
        
        CGPoint touchPoint  = [gestureRecognizer locationInView:self.view];
        //当点击的坐标不在导航栏时允许手势执行
        return !CGRectContainsPoint(self.navigationBar.frame, touchPoint);
    }
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
