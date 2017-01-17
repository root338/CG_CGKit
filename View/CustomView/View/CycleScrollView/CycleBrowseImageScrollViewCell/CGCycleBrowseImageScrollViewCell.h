//
//  CGCycleBrowseImageScrollViewCell.h
//  QuickAskCommunity
//
//  Created by DY on 2017/1/9.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGCycleBrowseImageScrollViewCell : UIView

@property (nonatomic, strong, readonly) UIImageView *imageView;

@property (nonatomic, assign, readonly) BOOL disableScrollZoom;

@property (nonatomic, assign) CGFloat minimumZoomScale;
@property (nonatomic, assign) CGFloat maximumZoomScale;

- (instancetype)initWithScrollZoom:(BOOL)scrollZoom NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
