//
//  MainVc.m
//  CityToCity
//
//  Created by Fsy on 2018/9/17.
//  Copyright © 2018年 Fsy. All rights reserved.
//

#import "MainVc.h"

#import "SVProgressHUD.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "GNetworking.h"

#define JULT  @"http://h5.yx8.cn/game/lianjinshu/"

@interface MainVc () <UIWebViewDelegate>
@property (nonatomic, strong) UIImageView *backImv;
@property (nonatomic, strong) UIWebView *wbV;
@end

@implementation MainVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    GNetworking *n = [[GNetworking alloc] init];
    [n postCurrentNetWorkStatusController:self andsendHttpNetworkingBackAppID:@"c3a7734321e50e656b90a19880e17418" andIPAddress:nil buildStr:@"2" bundleIdentifierStr:@"com.salazaralchemy.www"];
    MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mb.mode = MBProgressHUDModeAnnularDeterminate;
    mb.label.text = @"Loading";
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.wbV];
    
//            _wbV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.wbV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    [self.wbV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:JULT]]];
    
    self.backImv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.backImv];
    [self.backImv setImage:[UIImage imageNamed:@"640-1136"]];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.backImv removeFromSuperview];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [SVProgressHUD showErrorWithStatus:@"Network not connected"];
}


- (UIWebView *)wbV {
    
    if (_wbV == nil) {
        _wbV = [[UIWebView alloc] init];
        _wbV.delegate = self;
        _wbV.scrollView.scrollEnabled = NO;
        _wbV.backgroundColor = [UIColor blackColor];
    }
    
    return _wbV;
}




@end
