//
//  CGFCManager.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 *  参考文档：
 *          http://blog.csdn.net/u010590318/article/details/44629107
 *          http://nshipster.cn/nscache/
 *
 */

#import "CGFCManager.h"

#import "NSNotificationCenter+CGCreateNotification.h"

#if DEBUG
@interface CGFCManager ()<NSCacheDelegate>

@property (nonatomic, strong) NSCache *cacheManager;


@end

@implementation CGFCManager

+ (instancetype)sharedManager
{
    static CGFCManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        sharedManager  = [[CGFCManager alloc] init];
    });
    return sharedManager;
}

- (void)initialization
{
    _cacheManager   = [[NSCache alloc] init];
    //缓存1M
    _cacheManager.totalCostLimit    = 1024 * 1024;
    _cacheManager.delegate          = self;
}

- (UIFont *)cg_systemFontOfSize:(CGFloat)size
{
    NSString *fontName  = @"R";
    UIFont *font    = [self cg_getCacheFontWithFontName:fontName size:size];
    if (!font) {
        font    = [UIFont systemFontOfSize:size];
        [self cg_setCacheFont:font fontName:fontName size:size];
    }
    return font;
}

- (UIFont *)cg_boldSystemFontOfSize:(CGFloat)size
{
    NSString *fontName  = @"B";
    UIFont *font        = [self cg_getCacheFontWithFontName:fontName size:size];
    if (!font) {
        font            = [UIFont boldSystemFontOfSize:size];
        [self cg_setCacheFont:font fontName:fontName size:size];
    }
    return font;
}

- (UIFont *)cg_italicSystemFontOfSize:(CGFloat)size
{
    NSString *fontName  = @"I";
    UIFont *font        = [self cg_getCacheFontWithFontName:fontName size:size];
    if (!font) {
        font            = [UIFont italicSystemFontOfSize:size];
        [self cg_setCacheFont:font fontName:fontName size:size];
    }
    return font;
}

- (UIFont *)cg_fontName:(NSString *)fontName size:(CGFloat)size
{
    UIFont *font        = [self cg_getCacheFontWithFontName:fontName size:size];
    if (!font) {
        font            = [UIFont fontWithName:fontName size:size];
        !font ?: [self cg_setCacheFont:font fontName:fontName size:size];
    }
    return font;
}

- (UIColor *)cg_colorWithValue:(KCG_16_ColorValueType)colorValue
{
    NSString *key       = [self cg_colorCacheKeyWithValue:colorValue];
    UIColor *color      = [self.cacheManager objectForKey:key];
    if (!color) {
        color           = [UIColor colorWithValueType:colorValue];
        !color ?: [self.cacheManager setObject:color forKey:key];
    }
    return color;
}

#pragma mark - UIFont缓存设置
- (NSString *)cg_fontCacheKeyWithFontName:(NSString *)fontName size:(CGFloat)size
{
    return [NSString stringWithFormat:@"UIFont-%@-%f",fontName, size];
}

- (UIFont *)cg_getCacheFontWithFontName:(NSString *)fontName size:(CGFloat)size
{
    NSString *key   = [self cg_fontCacheKeyWithFontName:fontName size:size];
    UIFont *font    = [self.cacheManager objectForKey:key];
    if (![font isKindOfClass:[UIFont class]]) {
        font    = nil;
    }
    return font;
}

- (void)cg_setCacheFont:(UIFont *)font fontName:(NSString *)fontName size:(CGFloat)size
{
    NSString *key   = [self cg_fontCacheKeyWithFontName:fontName size:size];
    [self.cacheManager setObject:font forKey:key];
}

#pragma mark - UIColor缓存设置
- (NSString *)cg_colorCacheKeyWithValue:(KCG_16_ColorValueType)value
{
    return [NSString stringWithFormat:@"UIColor-%lu",(unsigned long)value];
}

#pragma mark - NSCacheDelegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    NSLog(@"%@   被释放", obj);
}
@end

#endif
