//
//  CGBaseWebView.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/19.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGBaseWebView : UIWebView


//////////////////////////////////////////////////////////////////

//**
//*注意：该属性只能在web完全加载好之后进行设置(即:webViewDidFinishLoad代理方法中设置)
//**

/** //禁止长按弹出选择框 */
@property (assign, nonatomic) BOOL isDisableTouchCallout;

/** //禁止用户选择 */
@property (assign, nonatomic) BOOL isDisableUserSelect;

//////////////////////////////////////////////////////////////////
@end
