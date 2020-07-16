//
//  CEUpayWebController.m
//  App
//
//  Created by 吴智民 on 2017/11/2.
//  Copyright © 2017年 HuanMingLi. All rights reserved.
//

#import "CEUpayWebController.h"

@interface CEUpayWebController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *wkMainWeb;
@property(nonatomic,copy)NSString* mUrl;
@end

@implementation CEUpayWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    
    self.title = @"银联支付";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_mUrl]];
    self.wkMainWeb.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.wkMainWeb setDelegate:self];
    [self.wkMainWeb loadRequest:request];
}

-(void)initData:(id)parameter
{
    self.mUrl = [NSString stringWithFormat:@"%@/exchange/cashierPayOrder/toPay?orderNo=%@",SERVAER_IP,parameter];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [FUPROGRESS_HUD loading:@"发送支付请求..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [FUPROGRESS_HUD complete];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [FUPROGRESS_HUD loading:[error localizedDescription]];
}

@end
