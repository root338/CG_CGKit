//
//  UIFont+CGCreateFont.m
//  TestCG_CGKit
//
//  Created by DY on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIFont+CGCreateFont.h"

@implementation UIFont (CGCreateFont)

+ (UIFont *)cg_defaultFontWithSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size];
}

+ (UIFont *)cg_defaultItalicFontWithSize:(CGFloat)size
{
    return [UIFont italicSystemFontOfSize:size];
}

+ (UIFont *)cg_defaultBoldFontWithSize:(CGFloat)size
{
    return [UIFont boldSystemFontOfSize:size];
}

#if __has_include(<CoreText/CoreText.h>)

+ (UIFont *)fontFromCTFontRef:(CTFontRef)fontRef
{
    CGFloat pointSize   = CTFontGetSize(fontRef);
    NSString *fontPostScriptName    = (NSString *)CFBridgingRelease(CTFontCopyPostScriptName(fontRef));
    UIFont *font    = [UIFont fontWithName:fontPostScriptName size:pointSize];
    return font;
}

+ (CTFontRef)fontRefFromUIFont:(UIFont *)font
{
    CTFontRef fontRef   = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    return CFAutorelease(fontRef);
}

#endif

@end
