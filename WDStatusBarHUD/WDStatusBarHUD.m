//
//  WDStatusBarHUD.m
//  127 状态栏HUD框架(WDStatusBarHUD)
//
//  Created by wudi on 16/7/8.
//  Copyright © 2016年 wudi. All rights reserved.
//

#import "WDStatusBarHUD.h"

#define WDScreenW [UIScreen mainScreen].bounds.size.width
#define WDStatusBarHeight 20
#define WDAnimationDuration 0.25f
#define WDHUDShowTime 2.0f
#define WDTextFontSize 13.0f

@implementation WDStatusBarHUD

// 由于该类的方法大多数为类方法,所以不能使用self来访问类对象,也不能使用属性
// 如果想让变量在方法结束后不被销毁,此时可以使用全局变量
// 全局变量一般在变量名后面添加 _下划线
static UIWindow *HUDWindow_;

static NSTimer *timer_;

+ (void)showWithMessage:(NSString *)message image:(UIImage *)image activityViewShow:(BOOL)isShow{
    
    // 每次来到该方法时,首先将上次窗口隐藏;并将上次的定时器停掉
    HUDWindow_.hidden = YES;
    [timer_ invalidate];
    timer_ = nil;
    
    
    // 创建一个窗口对象
    HUDWindow_ = [[UIWindow alloc] init];
    // 一旦给全局变量重新赋值,那么之前的对象将会销毁,所以多次点击HUD对象在内存中也只有一个值
    
    // 设置window尺寸
    HUDWindow_.frame = CGRectMake(0, 0, WDScreenW, WDStatusBarHeight);
    
    // 设置窗口颜色
    HUDWindow_.backgroundColor = [UIColor colorWithRed:34 / 255.0 green:78 / 255.0 blue:183 / 255.0 alpha:1];
    
    // 设置窗口优先级
    HUDWindow_.windowLevel = UIWindowLevelAlert;
    
    // 显示窗口
    // 窗口对象的显示只需要将其hidden改为NO即可
    HUDWindow_.hidden = NO;
    
    // 给窗口添加一个根视图
    
    
    // 向窗口中添加文字和图片(使用按钮来添加)
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = HUDWindow_.bounds;
    
    // 按钮不可点击
    btn.enabled = NO;
    
    [HUDWindow_ addSubview:btn];
    
    // 设置按钮文字和图片
    [btn setTitle:message forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:WDTextFontSize];
    
    [btn setImage:image forState:UIControlStateNormal];
    
    // 设置按钮文字和图片的距离
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    
    // 创建菊花对象
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] init];
    
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    // 计算文字的宽度
    CGFloat textWidth = [message sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:WDTextFontSize]}].width;
    
    // 计算菊花视图的center
    CGFloat centerX = (WDScreenW - textWidth) * 0.5 - 20;
    CGFloat centerY = HUDWindow_.bounds.size.height * 0.5;
    
    // 菊花视图的宽高固定,并且无法设置
    activity.center = CGPointMake(centerX, centerY);
    
    [HUDWindow_ addSubview:activity];
    
    [activity startAnimating];
    
    // 控制菊花视图的显示和隐藏
    activity.hidden = !isShow;
    
    
    // 执行动画,让窗口从上往下进入
    HUDWindow_.transform = CGAffineTransformMakeTranslation(0, -WDStatusBarHeight);
    
    [UIView animateWithDuration:WDAnimationDuration animations:^{
        
        HUDWindow_.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        // 动画执行完成后,根据isShow的值来决定窗口是否隐藏
        if (!isShow) {
            
            timer_ = [NSTimer scheduledTimerWithTimeInterval:WDHUDShowTime target:self selector:@selector(hide) userInfo:nil repeats:NO];
        }
    }];
}


+ (void)showWithMessage:(NSString *)message image:(UIImage *)image{
    
    [self showWithMessage:message image:image activityViewShow:NO];
}


+ (void)showSuccessWithMessage:(NSString *)message{
    
    [self showWithMessage:message image:[UIImage imageNamed:@"WDStatusBarHUD.bundle/success"]];
}


+ (void)showErrorWithMessage:(NSString *)message{
    
    [self showWithMessage:message image:[UIImage imageNamed:@"WDStatusBarHUD.bundle/error"]];
}


+ (void)showLoadingWithMessage:(NSString *)message{
    
    [self showWithMessage:message image:nil activityViewShow:YES];
}


+ (void)hide{
    
    // 执行动画,隐藏HUD
    [UIView animateWithDuration:WDAnimationDuration animations:^{
        
        HUDWindow_.transform = CGAffineTransformMakeTranslation(0, -WDStatusBarHeight);
    } completion:^(BOOL finished) {
       
        // 将全局变量置空,清除内存
        HUDWindow_ = nil;
        timer_ = nil;
    }];
    
}


@end
