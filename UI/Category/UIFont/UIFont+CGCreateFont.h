//
//  UIFont+CGCreateFont.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<CoreText/CoreText.h>)
#import <CoreText/CoreText.h>
#endif

NS_ASSUME_NONNULL_BEGIN
@interface UIFont (CGCreateFont)

#if __has_include(<CoreText/CoreText.h>)

+ (UIFont *)fontFromCTFontRef:(CTFontRef)fontRef;

+ (CTFontRef)fontRefFromUIFont:(UIFont *)font;

#endif


@end


NS_ASSUME_NONNULL_END
