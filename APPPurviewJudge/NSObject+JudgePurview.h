//
//  NSObject+JudgePurview.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
    判断应用是否有相应权限
 */
@interface NSObject (JudgePurview)

/** 验证是否可以访问相册 */
- (BOOL)cg_verifyIsAccessAssetsLibrary;

@end
