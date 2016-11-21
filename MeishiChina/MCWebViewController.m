//
// Created by Zheng on 21/11/2016.
// Copyright (c) 2016 Zheng. All rights reserved.
//

#import "MCWebViewController.h"
#import "MCWebView.h"
#import "MCWebViewProgress.h"
#import "MCWebViewProgressView.h"

@interface MCWebViewController () <UIWebViewDelegate, MCWebViewProgressDelegate>
@property (nonatomic, strong) MCWebView *webView;
@property (nonatomic, strong) MCWebViewProgressView *progressView;
@property (nonatomic, strong) MCWebViewProgress *progressProxy;
@property (nonatomic, strong) UIBarButtonItem *shareItem;

@end

@implementation MCWebViewController

- (void)setup {
    [super setup];
    self.hidesBottomBarWhenPushed = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.shareItem;

    [self.view addSubview:self.webView];
    [self loadWebView];
}

- (void)loadWebView {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [self.progressView removeFromSuperview];
}

#pragma mark - Getters

- (MCWebViewProgress *)progressProxy {
    if (!_progressProxy) {
        MCWebViewProgress *progressProxy = [[MCWebViewProgress alloc] init]; // instance variable
        progressProxy.webViewProxyDelegate = self;
        progressProxy.progressDelegate = self;
        _progressProxy = progressProxy;
    }
    return _progressProxy;
}

- (MCWebViewProgressView *)progressView {
    if (!_progressView) {
        CGFloat progressBarHeight = 2.f;
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
        MCWebViewProgressView *progressView = [[MCWebViewProgressView alloc] initWithFrame:barFrame];
        progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        progressView.progressTintColor = MConfig.appearance.progressViewTintColor;
        _progressView = progressView;
    }
    return _progressView;
}

- (MCWebView *)webView {
    if (!_webView) {
        MCWebView *webView = [[MCWebView alloc] initWithFrame:self.view.bounds];
        webView.delegate = self.progressProxy;
        webView.allowsInlineMediaPlayback = YES;
        webView.scalesPageToFit = YES;
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView = webView;
    }
    return _webView;
}

- (UIBarButtonItem *)shareItem {
    if (!_shareItem) {
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareItemTapped:) ];
        anotherButton.tintColor = [UIColor whiteColor];
        anotherButton.enabled = NO;
        _shareItem = anotherButton;
    }
    return _shareItem;
}

- (void)shareItemTapped:(UIBarButtonItem *)sender {
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[self.url] applicationActivities:nil];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView == _webView && _progressView) {
        [_progressView setProgress:0.0 animated:YES];
    }
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title && title.length > 0) {
        self.title = title;
    }
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.navigationController.view makeToast:[error localizedDescription]];
}

#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(MCWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [self.progressView setProgress:progress animated:YES];
}

#pragma mark - Memory

- (void)dealloc {
    MCLog(@"");
}

@end