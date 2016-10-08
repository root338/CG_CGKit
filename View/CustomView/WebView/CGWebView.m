//
//  CGWebView.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/19.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGWebView.h"

#import "UIView+CGAddConstraints.h"

//代理实现类
#import "CGUIWebViewDelegateManager.h"
#import "CGWKWebViewDelegateManager.h"

#import "CGPrintLogHeader.h"

@import WebKit;

@interface CGWebView<ObjectType> ()<UIWebViewDelegate>
{
    CGUIWebViewDelegateManager  *_delegateManagerForUIWebView;
    CGWKWebViewDelegateManager  *_delegateManagerForWKWebView;
}

@property (nonatomic, strong, readwrite) IBOutlet ObjectType webView;

@property (nonatomic, assign, readwrite) CGWebViewType webViewType;
@property (nonatomic, readonly) CGWebViewType currentWebViewType;

@property (nonatomic, readonly) UIWebView *webViewForUIWebView;
@property (nonatomic, readonly) WKWebView *webViewForWKWebView;
@end

@implementation CGWebView

+ (BOOL)isWebKitAvailable
{
    return [WKWebView class] == nil ? NO : YES;
}

#pragma mark - 初始化CGWebView
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame webViewType:CGWebViewTypeAuto];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithWebViewType:(CGWebViewType)webViewType
{
    return [self initWithFrame:CGRectZero webViewType:webViewType];
}

- (instancetype)initWithFrame:(CGRect)frame webViewType:(CGWebViewType)webViewType
{
    return [self initWithFrame:frame webViewType:webViewType configuration:nil];
}

- (instancetype)initWithFrame:(CGRect)frame webViewType:(CGWebViewType)webViewType configuration:(WKWebViewConfiguration *)configuration
{
    self = [super initWithFrame:frame];
    if (self) {
        if (webViewType == CGWebViewTypeWKWebView) {
            if (![CGWebView isWebKitAvailable]) {
                
                CGDebugAssert(nil, @"不支持WKWebview");
                webViewType = CGWebViewTypeUIWebView;
            }
        }
        _webViewType    = webViewType;
        [self createWebViewWithFrame:frame configuration:configuration];
    }
    return self;
}

#pragma mark - 创建子视图
- (void)createWebViewWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration
{
    
    id webView  = nil;
    switch (self.currentWebViewType) {
        case CGWebViewTypeWKWebView:
        {
            webView = [self createWKWebViewWithFrame:frame configuration:configuration];
        }
            break;
        case CGWebViewTypeUIWebView:
        {
            webView = [self createUIWebViewWithFrame:frame];
        }
            break;
        default:
            break;
    }
    _webView    = webView;
    [self addSubview:webView];
    [webView cg_autoEdgesInsetsZeroToSuperview];
}

- (UIWebView *)createUIWebViewWithFrame:(CGRect)frame
{
    return [[UIWebView alloc] initWithFrame:frame];
}

- (WKWebView *)createWKWebViewWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration
{
    if (configuration) {
        return [[WKWebView alloc] initWithFrame:frame configuration:configuration];
    }else {
        return [[WKWebView alloc] initWithFrame:frame];
    }
}

//设置代理管理类
- (void)setupDelegateManager
{
    if (self.currentWebViewType == CGWebViewTypeUIWebView) {
        
        _delegateManagerForUIWebView    = [CGUIWebViewDelegateManager createManagerWithDelegate:self.delegate targetObj:self];
        self.webViewForUIWebView.delegate   = _delegateManagerForUIWebView.webViewProxyDelegate;
        
    }else if (self.currentWebViewType == CGWebViewTypeWKWebView) {
        
        _delegateManagerForWKWebView            = [CGWKWebViewDelegateManager createManagerWithDelegate:self.delegate targetObj:self];
        _delegateManagerForWKWebView.webView    = self.webViewForWKWebView;
        self.webViewForWKWebView.navigationDelegate = _delegateManagerForWKWebView;
    }
}

- (void)dealloc
{
    if (self.currentWebViewType == CGWebViewTypeWKWebView) {
        //需要在释放前，手动释放CGWKWebViewDelegateManager类开启的KVO，否则会发生运行错误
        _delegateManagerForWKWebView.webView = nil;
    }
}

#pragma mark - 设置属性
- (void)setDelegate:(id<CGWebViewDelegate>)delegate
{
    if (_delegate != delegate) {
        
        _delegate   = delegate;
        [self setupDelegateManager];
    }
}

- (CGWebViewType)currentWebViewType
{
    if (self.webViewType == CGWebViewTypeAuto) {
        if ([CGWebView isWebKitAvailable]) {
            return  CGWebViewTypeWKWebView;
        }else {
            return  CGWebViewTypeUIWebView;
        }
    }else {
        return self.webViewType;
    }
}

- (UIWebView *)webViewForUIWebView
{
    if ([self.webView isKindOfClass:[UIWebView class]]) {
        return self.webView;
    }
    return nil;
}

- (WKWebView *)webViewForWKWebView
{
    if ([CGWebView isWebKitAvailable]) {
        if ([self.webView isKindOfClass:[WKWebView class]]) {
            return self.webView;
        }
    }
    return nil;
}

@end
