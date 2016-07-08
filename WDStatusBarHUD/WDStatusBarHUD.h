//
//  WDStatusBarHUD.h
//  127 状态栏HUD框架(WDStatusBarHUD)
//
//  Created by wudi on 16/7/8.
//  Copyright © 2016年 wudi. All rights reserved.
//

// 参考SVProgressHUD来设计状态栏HUD
/*
 状态栏HUD设计原则
    1 UIWindow有三个级别:UIWindowLevelNormal \ UIWindowLevelAlert \ UIWindowLevelStatusBar
    2 三种UIWindow的级别由低到高为normal --> statusBar --> alert
    3 状态栏属于一个UIWindow,并且其级别正是statusBar
    4 在AppDelegate中我们知道,所有的UI控件都是添加到主窗口中显示出来的.并且主窗口的级别为normal
    5 所以一般情况下,屏幕中通常至少有两个UIWindow,一个是statusBar,一个是主窗口;并且statusBar永远在最前面
 
    状态栏HUD正是需要用一个窗口显示在statusBar的前面,所以这个HUD不能是UI控件,而必须是UIWindow,并且级别要比statusBar高
    通常状态栏HUD就是一个UIWindow,并且设置其级别为UIWindowLevelAlert
 */

#import <UIKit/UIKit.h>

@interface WDStatusBarHUD : UIWindow

/** 显示成功状态 */
+ (void)showSuccessWithMessage:(NSString *)message;
/** 显示失败状态 */
+ (void)showErrorWithMessage:(NSString *)message;
/** 显示普通状态 */
+ (void)showWithMessage:(NSString *)message image:(UIImage *)image;
/** 显示加载状态 */
+ (void)showLoadingWithMessage:(NSString *)message;
/** 隐藏HUD */
+ (void)hide;

@end
