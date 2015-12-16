//
//  MeeWebController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/12/16.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeWebController.h"

@interface MeeWebController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem ;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;


@end

@implementation MeeWebController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    //self.automaticallyAdjustsScrollViewInsets = NO; // 不自动添加scroolView的顶部 64内边距
    // 如果在 xib / storyBoard中 scrollView在顶一个位置，此时会增加 64的内边距
    // 如果不在，就不会自己增加，可以手动增加
    // self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
   
}

#pragma mark -UIWebViewDelegate
// 是否要加载某个请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

// 网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

- (IBAction)refreshClick:(id)sender {
    [self.webView reload];
}


- (IBAction)goForward:(id)sender {
    
    [self.webView goForward];
}
- (IBAction)goBackClick:(id)sender {
    [self.webView goBack];
}

@end
