//
//  CGImageLibraryManager.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGImageLibraryManager.h"

@interface CGImageLibraryManager ()

@property (nonatomic, strong, readwrite) CGAssetsCollectionManager *assetsCollectionManager;
@end

@implementation CGImageLibraryManager

#pragma mark - 设置属性

- (CGAssetsCollectionManager *)assetsCollectionManager
{
    if (_assetsCollectionManager) {
        return _assetsCollectionManager;
    }
    
    _assetsCollectionManager = [[CGAssetsCollectionManager alloc] init];
    
    return _assetsCollectionManager;
}

@end
