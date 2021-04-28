//
//  ViewController.m
//  OCDemo
//
//  Created by Jimmy King on 2021/4/25.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "ChartView.h"

@interface ViewController ()<WKUIDelegate, WKScriptMessageHandler>

@property (strong, nonatomic)UIButton *button;

@property (strong, nonatomic)WKWebView *webview;

@property (strong, nonatomic)ChartView *chartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSDemo.html" ofType:nil];
    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webview loadHTMLString:htmlString baseURL:nil];
    
    [self.view addSubview:self.button];
    [self.view addSubview:self.webview];
}


-(void)clickButton:(UIButton *)sender {
    [self.webview evaluateJavaScript:@"jsAlert('OC调用JS')" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSLog(@"OC调用JS回调");
    }];
}

#pragma WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    completionHandler();
    NSLog(@"%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    NSLog(@"222");
}

-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    NSLog(@"333");
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"ocAlert"]) {
        NSLog(@"js调用oc");
    }
}


- (ChartView *)chartView {
    if (!_chartView) {
        _chartView = [[ChartView alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width)];
    }
    return _chartView;
}

- (WKWebView *)webview {
    if (!_webview) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *controller = [[WKUserContentController alloc] init];
        [controller addScriptMessageHandler:self name:@"ocAlert"];
        configuration.userContentController = controller;
        _webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 260, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration:configuration];
        _webview.UIDelegate = self;
    }
    return _webview;
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 50)];
        [_button setTitle:@"OC调用JS" forState:UIControlStateNormal];
        _button.backgroundColor = UIColor.orangeColor;
        [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
