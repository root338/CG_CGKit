//
//  CGWKWebViewUIDelegateManager.m
//  TestCG_CGKit
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWKWebViewUIDelegateManager.h"

#import "CGWebView.h"

#import "UIView+CGSearchView.h"
#import "UIViewController+CGAlert.h"

@interface CGWKWebViewUIDelegateManager ()

@property (nonatomic, readonly) CGWebView *webView;
@property (nonatomic, readonly) id<CGWebViewDelegate> delegate;

@property (nullable, nonatomic, weak) UIAlertController *alertController;

@end

@implementation CGWKWebViewUIDelegateManager

+ (instancetype)createManagerWithWebViewPrivateProxyDelegate:(id<CGWebViewPrivateProxyDelegate>)webViewPrivateProxyDelegate
{
    CGWKWebViewUIDelegateManager *UIDelegateManager = [[self alloc] init];
    UIDelegateManager.webViewPrivateProxyDelegate   = webViewPrivateProxyDelegate;
    return UIDelegateManager;
}

- (CGWebView *)webView
{
    return self.webViewPrivateProxyDelegate.webViewForPrivateObject;
}

- (id<CGWebViewDelegate>)delegate
{
    return self.webView.delegate;
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    if ([self.delegate respondsToSelector:@selector(webView:runJavaScriptAlertPanelWithMessage:initiatedByFrame:completionHandler:)]) {
        [self.delegate webView:self.webView runJavaScriptAlertPanelWithMessage:message initiatedByFrame:frame completionHandler:completionHandler];
    }else {
        
        UIViewController *viewController    = [self alertViewController];
        if (viewController) {
            [viewController showAlertViewWithTitle:nil message:message cancelTitle:@"确定" otherTitle:nil resultCallback:^(BOOL isCancel) {
                if (completionHandler) {
                    completionHandler();
                }
            }];
        }else {
            if (completionHandler) {
                completionHandler();
            }
        }
    }
}

// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler
{
    if ([self.delegate respondsToSelector:@selector(webView:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:completionHandler:)]) {
        [self.delegate webView:self.webView runJavaScriptConfirmPanelWithMessage:message initiatedByFrame:frame completionHandler:completionHandler];
    }else {
        UIViewController *viewController    = [self alertViewController];
        if (viewController) {
            [viewController showAlertViewWithTitle:nil message:message cancelTitle:@"取消" otherTitle:@"确定" resultCallback:^(BOOL isCancel) {
                if (completionHandler) {
                    completionHandler(!isCancel);
                }
            }];
        }else {
            if (completionHandler) {
                completionHandler(NO);
            }
        }
    }
}

// JS端调用prompt函数时，会触发此方法
// 要求输入一段文本
// 在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    if ([self.delegate respondsToSelector:@selector(webView:runJavaScriptTextInputPanelWithPrompt:defaultText:initiatedByFrame:completionHandler:)]) {
        [self.delegate webView:self.webView runJavaScriptTextInputPanelWithPrompt:prompt defaultText:defaultText initiatedByFrame:frame completionHandler:completionHandler];
    }else {
        
        void (^handleInputCompletionBlock) (NSString * _Nullable) = ^(NSString * _Nullable inputText) {
            if (completionHandler) {
                completionHandler(inputText);
            }
        };
        UIViewController *viewController    = [self alertViewController];
        if (viewController) {
            
            __weak __block typeof(self) weakself = self;
            self.alertController = [viewController showAlertControllerWithTitle:nil message:prompt textInputsCount:1 setupTextField:^(UITextField * _Nonnull textField, NSInteger textFieldIndex) {
                textField.text  = defaultText;
            } cancelTitle:@"取消" otherTitles:@[@"确定"] resultCallback:^(UIAlertAction * _Nonnull alertAction) {
                
                NSString *inputText = nil;
                if (alertAction.style != UIAlertActionStyleCancel) {
                    inputText   = [[weakself.alertController.textFields firstObject] text];
                }
                handleInputCompletionBlock(inputText);
            }];
        }else {
            handleInputCompletionBlock(nil);
        }
    }
}

- (UIViewController *)alertViewController
{
    UIViewController *viewController    = nil;
    if (self.webView.viewController) {
        viewController  = self.webView.viewController;
    }else {
        viewController  = self.webView.viewControllerForLate;
    }
    return viewController;
}

@end
