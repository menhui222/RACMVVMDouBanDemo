//
//  WKTabBarController.m
//  IflyAPP
//
//  Created by mac on 15/12/18.
//  Copyright © 2015年 iasku. All rights reserved.
//


#import "WKMyViewController.h"
#import "WKBookViewController.h"
#import "WKMoiveViewController.h"
#import "WKMusicViewController.h"
#import "WKTabBarController.h"
#import "WKBadgeButton.h"
#import "WKTabBarButton.h"
#import "WKTabBarView.h"
#import "WKNavigationController.h"

@interface WKTabBarController ()<WKTabBarViewDelegate>

@property (nonatomic, strong) WKTabBarView *tabBarView;
@end

@implementation WKTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    // 自定义tabBarView
    [self setupTabBarView];
    
    // 初始化所有子控制器
    [self setupAllChildViewControllers];
}

/**
 *  自定义tabBarView
 */
- (void)setupTabBarView
{
    WKTabBarView *tabBarView = [[WKTabBarView alloc] init];
    tabBarView.frame = self.tabBar.bounds;
    tabBarView.delegate = self;
    //tabBarView.backgroundColor = [UIColor colorFromHexCode:SubjectColor];
    [self.tabBar addSubview:tabBarView];
    self.tabBarView = tabBarView;
}

#pragma mark - WKTabBarViewDelegate method

- (void)tabBarView:(WKTabBarView *)tabBarView didSelectedButtonFrom:(int)from to:(int)to
{
    // 切换控制器
    self.selectedIndex = to;
}

- (void)tabBarViewSendStatus:(WKTabBarView *)tabBarView
{
   
}

#pragma mark -

/**
 *  删除自带按钮
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化所有子控制器
 */
- (void)setupAllChildViewControllers
{
    WKBookViewController *book = [[WKBookViewController alloc] init];

    [self setupChildViewController:book title:@"书籍"
                         imageName:@"tab_icon_friend_normal"
                 selectedImageName:@"tab_icon_friend_press"];
    
    WKMoiveViewController *moive = [[WKMoiveViewController alloc] init];
    //home2.tabBarItem.badgeValue = @"";
    [self setupChildViewController:moive title:@"电影"
                         imageName:@"tab_icon_more_normal"
                 selectedImageName:@"tab_icon_more_press"];
    
    WKMusicViewController *music = [[WKMusicViewController alloc] init];
    //home3.tabBarItem.badgeValue = @"1";
    [self setupChildViewController:music title:@"音乐"
                         imageName:@"tab_icon_news_normal"
                 selectedImageName:@"tab_icon_news_press"];
    WKMyViewController *home4 = [[WKMyViewController alloc] init];
    [self setupChildViewController:home4 title:@"我"
                         imageName:@"tab_icon_quiz_normal"
                 selectedImageName:@"tab_icon_quiz_press"];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

/**
 *  初始化一个子控制器
 *
 *  @param VC                子控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */
- (void)setupChildViewController:(UIViewController *)VC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 给tabBarItem设置数据
    VC.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:imageName];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 初始化导航控制器
    WKNavigationController *nav = [[WKNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
    
    // 添加tabBarView内部按钮
    [self.tabBarView addTabBarButtonWithItem:VC.tabBarItem];
}


@end
