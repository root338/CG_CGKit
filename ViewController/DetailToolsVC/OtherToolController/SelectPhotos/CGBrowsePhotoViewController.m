//
//  CGBrowsePhotoViewController.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBrowsePhotoViewController.h"

#import "CGCollectionView.h"
#import "CGNavigationBarView.h"
#import "CGBrowsePhotoCollectionViewCell.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CGAddConstraints.h"
#import "UIScrollView+CGProperty.h"
#import "UIView+CGAddGestureRecognizer.h"
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

- (void)handleSingleTap:(UITapGestureRecognizer *)tapGestureRecognizer
{
    BOOL isHidden   = !self.navigationBar.hidden;
    [self setNavigationBarHidden:isHidden animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    
    self.navigationBarView.isContentViewFullScreen  = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cg_setupBrowsePhotoListView];
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
    
    //如果直接添加到contentView会因为状态栏的显隐而相应变化
    [self.navigationBarView insertSubview:_browsePhotoCollectionView belowSubview:self.navigationBar];
    [_browsePhotoCollectionView cg_autoEdgesInsetsZeroToSuperview];
    
    Class registerCollectionCellClassName   = [CGBrowsePhotoCollectionViewCell class];
    [_browsePhotoCollectionView cg_registerReuseClass:registerCollectionCellClassName];
    
    __weak typeof(self) weakSelf    = self;
    _dataSourceManager  = [[CGCollectionViewDataSourceManager alloc] initWithDataSource:self.browsePhotoDataSource cellIdentifierForClass:registerCollectionCellClassName setupCellBlock:^(UICollectionView * _Nonnull collectionView, __kindof CGBrowsePhotoCollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
        
        [cell setupCollectionViewCellContentWithData:data];
        [cell addSingleTapTarget:weakSelf action:@selector(handleSingleTap:)];
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

#pragma mark - 屏幕旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self updateCollectionViewLayoutWithItemSize:size];
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self updateCollectionViewLayoutWithItemSize:self.view.size];
}

#endif

- (void)updateCollectionViewLayoutWithItemSize:(CGSize)itemSize;
{
    CGBrowseImageCollectionViewFlowLayout *flowLayout   = (id)self.browsePhotoCollectionView.collectionViewLayout;
    if ([flowLayout isKindOfClass:[CGBrowseImageCollectionViewFlowLayout class]]) {
        flowLayout.itemSize = itemSize;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setupTitleWithPage:[scrollView cg_calculateScrollPageWithScale:0.5]];
}

- (void)setupTitleWithPage:(NSInteger)page
{
    if (page < 1 || page > self.browsePhotoDataSource.count) {
        CGErrorLog(@"现在的索引为%li 索引应 大于0 小于%lu", (long)page, self.browsePhotoDataSource.count);
        return ;
    }
    
    self.title  = [NSString stringWithFormat:@"%li/%lu", (long)page, self.browsePhotoDataSource.count];
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
