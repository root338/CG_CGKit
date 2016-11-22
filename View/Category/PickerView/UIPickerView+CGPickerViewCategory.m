//
//  UIPickerView+CGPickerViewCategory.m
//  QuickAskCommunity
//
//  Created by DY on 2016/11/21.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIPickerView+CGPickerViewCategory.h"

#import <objc/runtime.h>

@implementation UIPickerView (CGVerify)

- (BOOL)availableWithComponent:(NSInteger)component
{
    return [self numberOfComponents] > component;
}

- (BOOL)availableWithRow:(NSInteger)row inComponent:(NSInteger)component
{
    return [self availableWithComponent:component] && [self numberOfRowsInComponent:component] > row;
}

@end

@implementation UIPickerView (CGSelect)

- (BOOL)cg_selectRow:(NSInteger)row inComponent:(NSInteger)component
{
    return [self cg_selectRow:row inComponent:component animated:self.disableSelectAnimated];
}

- (BOOL)cg_selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    BOOL result = NO;
    if ([self availableWithRow:row inComponent:component]) {
        
        result  = YES;
        [self selectRow:row inComponent:component animated:animated];
    }
    
    return result;
}

- (BOOL)cg_reloadComponent:(NSInteger)component
{
    BOOL result = NO;
    if ([self availableWithComponent:component]) {
        result  = YES;
        [self reloadComponent:component];
    }
    return result;
}

- (NSInteger)cg_selectedRowInComponent:(NSInteger)component
{
    if ([self availableWithComponent:component]) {
        return [self selectedRowInComponent:component];
    }
    return 0;
}

#pragma mark - 设置属性

- (void)setDisableSelectAnimated:(BOOL)disableAnimated
{
    objc_setAssociatedObject(self, @selector(disableSelectAnimated), @(disableAnimated), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)disableSelectAnimated
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
