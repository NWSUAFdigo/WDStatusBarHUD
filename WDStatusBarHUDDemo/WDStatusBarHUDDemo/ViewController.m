//
//  ViewController.m
//  127 状态栏HUD框架(WDStatusBarHUD)
//
//  Created by wudi on 16/7/8.
//  Copyright © 2016年 wudi. All rights reserved.
//

#import "ViewController.h"
#import "WDStatusBarHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)normalClick:(id)sender {
    
    [WDStatusBarHUD showWithMessage:@"正在处理" image:[UIImage imageNamed:@"WDStatusBarHUD.bundle/success"]];
}


- (IBAction)successClick:(id)sender {
    
    [WDStatusBarHUD showSuccessWithMessage:@"登录完成!!"];
}


- (IBAction)errorClick:(id)sender {
    
    [WDStatusBarHUD showErrorWithMessage:@"登录失败!!"];
}


- (IBAction)loadingClick:(id)sender {
    
    [WDStatusBarHUD showLoadingWithMessage:@"正在加载..."];
}


- (IBAction)hideClick:(id)sender {
    
    [WDStatusBarHUD hide];
}

@end
