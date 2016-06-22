//
//  WKNavigationController.m
//  IflyAPP
//
//  Created by mac on 15/12/18.
//  Copyright © 2015年 iasku. All rights reserved.
//
// 获取RGB颜色

#define WKColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import "WKNavigationController.h"

@implementation WKNavigationController


+ (void)initialize
{
    // 设置BarButtonItem
    UINavigationBar *navBar = [UINavigationBar appearance];
    
  
    
    // 设置导航栏变得不透明 ， 使得视图的坐标的原点从导航栏下边缘开始，也可以设置背景图片达到这个效果
    navBar.translucent = YES;
    
    // 设置导航栏背景颜色
    navBar.barTintColor = kSujectColor;
    //titlecolor
    UIColor * color = [UIColor whiteColor];
    
    NSDictionary * dict =@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:color};
    
    
    navBar.titleTextAttributes = dict;
    navBar.tintColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

//  让 状态栏字体 白色  。。
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
