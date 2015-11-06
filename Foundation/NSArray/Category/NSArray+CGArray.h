//
//  NSArray+CGArray.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/6.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<__covariant ObjectType> (CGArray)

- (ObjectType)cg_objectAtIndex:(NSUInteger)index;

@end
