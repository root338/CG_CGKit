//
//  UIWebView+CGValue.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/12.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIWebView (CGValue)

//////////////////////////////////////////////////////////////////

//**
//*注意：
//*     1.该属性只能在web完全加载好之后进行设置(即:webViewDidFinishLoad代理方法中设置)
//*     2.当相关js加载好之后也可以调用
//**

/** //禁止长按弹出选择框 */
@property (assign, nonatomic, getter=isDisableTouchCallout) BOOL disableTouchCallout;

/** //禁止用户选择 */
@property (assign, nonatomic, getter=isDisableUserSelect) BOOL disableUserSelect;

@property (nullable, nonatomic, strong, readonly) NSString *title;

@property (nullable, nonatomic, strong, readonly) NSString *HTML;

//////////////////////////////////////////////////////////////////
@end

NS_ASSUME_NONNULL_END
