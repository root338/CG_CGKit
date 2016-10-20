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

#import "CGWebViewPrivateProxyDelegate.h"

#import "UIWebView+CGValue.h"

#import "CGPrintLogHeader.h"

@import WebKit;

@interface CGWebView<ObjectType> ()<CGWebViewPrivateProxyDelegate>
{
    CGUIWebViewDelegateManager  *_delegateManagerForUIWebView;
    CGWKWebViewDelegateManager  *_delegateManagerForWKWebView;
}

@property (nonatomic, strong, readwrite) IBOutlet ObjectType webView;

@property (nonatomic, assign, readwrite) CGWebViewType webViewType;
@property (nonatomic, readonly) CGWebViewType currentWebViewType;

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
    UIWebView *webView  = [[UIWebView alloc] initWithFrame:frame];
    return webView;
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
        
        if (_delegateManagerForUIWebView == nil) {
            _delegateManagerForUIWebView    = [CGUIWebViewDelegateManager createManagerWithDelegate:self.delegate webViewPrivateProxyDelegate:self];
            self.webViewForUIWebView.delegate   = _delegateManagerForUIWebView.webViewProxyDelegate;
            
        }else {
            _delegateManagerForUIWebView.delegate   = self.delegate;
        }
        
    }else if (self.currentWebViewType == CGWebViewTypeWKWebView) {
        
        if (_delegateManagerForWKWebView == nil) {
            
            _delegateManagerForWKWebView            = [CGWKWebViewDelegateManager createManagerWithDelegate:self.delegate webViewPrivateProxyDelegate:self];
            self.webViewForWKWebView.navigationDelegate = _delegateManagerForWKWebView;
            [_delegateManagerForWKWebView openWebViewMonitor];
        }else {
            _delegateManagerForWKWebView.delegate   = self.delegate;
        }
    }
}

#pragma mark - CGWebViewPrivateProxyDelegate
- (CGWebView *)webViewForPrivateObject
{
    return self;
}

- (void)dealloc
{
    if (self.currentWebViewType == CGWebViewTypeWKWebView) {
        //需要在释放前，手动释放CGWKWebViewDelegateManager类开启的KVO，否则会发生运行错误
        _delegateManagerForWKWebView                    = nil;
        
        //当使用WKWebView，并实现scrollView的UIScrollView协议时需要在WKWebView释放时将scrollView.delegate置为nil
        //否则会发生运行错误:-[WKScrollViewDelegateForwarder release]: message sent to deallocated instance 0x170c3cc60
        self.webViewForWKWebView.scrollView.delegate    = nil;
    }
}

#pragma mark - 兼容API方法
- (void)loadRequest:(NSURLRequest *)request
{
    if ([self.webView respondsToSelector:@selector(loadRequest:)]) {
        
        if (self.webViewForUIWebView) {
            [self.webViewForUIWebView loadRequest:request];
        }else if (self.webViewForWKWebView) {
            [self.webViewForWKWebView loadRequest:request];
        }
        
    }else {
        CGErrorLog(@"没有%@方法", NSStringFromSelector(_cmd));
    }
}

- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL
{
    if ([self.webView respondsToSelector:@selector(loadHTMLString:baseURL:)]) {
        
        if (self.webViewForUIWebView) {
            [self.webViewForUIWebView loadHTMLString:string baseURL:baseURL];
        }else if (self.webViewForWKWebView) {
            [self.webViewForWKWebView loadHTMLString:string baseURL:baseURL];
        }
        
    }else {
        CGErrorLog(@"没有%@方法", NSStringFromSelector(_cmd));
    }
}

- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL
{
    if ([self.webView respondsToSelector:@selector(loadData:MIMEType:textEncodingName:baseURL:)]) {
        
        if (self.webViewForUIWebView) {
            [self.webViewForUIWebView loadData:data MIMEType:MIMEType textEncodingName:textEncodingName baseURL:baseURL];
        }else if (self.webViewForWKWebView) {
            [self.webViewForWKWebView loadData:data MIMEType:MIMEType characterEncodingName:textEncodingName baseURL:baseURL];
        }
        
    }else {
        CGErrorLog(@"没有%@方法", NSStringFromSelector(_cmd));
    }
}

- (void)reload
{
    if (self.webViewForUIWebView) {
        [self.webViewForUIWebView reload];
    }else if (self.webViewForWKWebView) {
        [self.webViewForWKWebView reload];
    }
}

- (void)stopLoading
{
    if (self.webViewForUIWebView) {
        [self.webViewForUIWebView stopLoading];
    }else if (self.webViewForWKWebView) {
        [self.webViewForWKWebView stopLoading];
    }
}

- (void)goBack
{
    if (self.webViewForUIWebView) {
        [self.webViewForUIWebView goBack];
    }else if (self.webViewForWKWebView) {
        [self.webViewForWKWebView goBack];
    }
}

- (void)goForward
{
    if (self.webViewForUIWebView) {
        [self.webViewForUIWebView goForward];
    }else if (self.webViewForWKWebView) {
        [self.webViewForWKWebView goForward];
    }
}

#pragma mark - 兼容扩展API
- (void)loadRequestWithURLString:(NSString *)urlString
{
    NSURL *url  = [NSURL URLWithString:urlString];
    if (url) {
        NSURLRequest *request   = [NSURLRequest requestWithURL:url];
        [self loadRequest:request];
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

- (void)setDelegateForUIWebView:(id<UIWebViewDelegate>)delegateForUIWebView
{
    _delegateForUIWebView               = delegateForUIWebView;
    self.webViewForUIWebView.delegate   = delegateForUIWebView;
    _delegateManagerForUIWebView        = nil;
}

- (void)setDelegateForWKWebView:(id<WKNavigationDelegate>)delegateForWKWebView
{
    _delegateForWKWebView                       = delegateForWKWebView;
    self.webViewForWKWebView.navigationDelegate = delegateForWKWebView;
    _delegateManagerForWKWebView                = nil;
}

- (void)setUIDelegateForWKWebView:(id)UIDelegateForWKWebView
{
    _UIDelegateForWKWebView             = UIDelegateForWKWebView;
    self.webViewForWKWebView.UIDelegate = UIDelegateForWKWebView;
}

#pragma mark - 兼容实例属性
- (UIScrollView *)scrollView
{
    if ([self.webView respondsToSelector:@selector(scrollView)]) {
        return [self.webView scrollView];
    }
    return nil;
}

- (NSString *)title
{
    if ([self.webView respondsToSelector:@selector(title)]) {
        return [self.webView title];
    }
    return nil;
}

- (BOOL)canGoBack
{
    if ([self.webView respondsToSelector:@selector(canGoBack)]) {
        return [self.webView canGoBack];
    }
    return NO;
}

- (BOOL)canGoForward
{
    if ([self.webView respondsToSelector:@selector(canGoForward)]) {
        return [self.webView canGoForward];
    }
    return NO;
}

- (BOOL)isLoading
{
    if ([self.webView respondsToSelector:@selector(isLoading)]) {
        return [self.webView isLoading];
    }
    return YES;
}

@end
