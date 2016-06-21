//
//  CGTextFieldDelegateManager.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/20.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 判断输入文本的类型 */
typedef NS_OPTIONS(NSInteger, CGInputStringVeriftyType) {
    
    /** 任意类型 */
    CGInputStringVeriftyTypeNone        = 0,
    /** 数字 */
    CGInputStringVeriftyTypeNumber      = 1 << 0,
    
};

/** 单个文本判断条件 */
@interface CGTextFieldTextVeriftyObject : NSObject

/** 验证的类型 */
@property (nonatomic, assign) CGInputStringVeriftyType verityType;

/** 最小输入数，默认值 0 允许为空 */
@property (nonatomic, assign) NSUInteger minInputCount;
/** 最大输入数，默认值 0 表示没有限制 */
@property (nonatomic, assign) NSUInteger maxInputCount;

@end

/** 文本输入代理 */
@interface CGTextFieldDelegateManager : NSObject<UITextFieldDelegate>

/** 验证的类型 */
@property (nonatomic, assign) CGInputStringVeriftyType verityType;

/** 最小输入数，默认值 0 允许为空 */
@property (nonatomic, assign) NSUInteger minInputCount;
/** 最大输入数，默认值 0 表示没有限制 */
@property (nonatomic, assign) NSUInteger maxInputCount;

/** 添加多个字符串的判断，！！！注意循环引用 */
//@property (nullable, nonatomic, strong) NSMutableDictionary<UITextField *, CGTextFieldTextVeriftyObject *> *textFieldsVeriftyObjectsDict;

//需要手动开启，手动关闭
/** 开启输入文本框文本改变通知 */
- (void)openTextFieldTextDidChangeNotification;
/** 关闭输入文本框文本改变通知 */
- (void)closeTextFieldTextDidChangeNotification;
@end

NS_ASSUME_NONNULL_END