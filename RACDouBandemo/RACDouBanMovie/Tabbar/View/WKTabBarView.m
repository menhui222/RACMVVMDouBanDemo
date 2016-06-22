//
//  WKTabBarView.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKTabBarView.h"
#import "WKTabBarButton.h"

@interface WKTabBarView ()

@property (nonatomic, strong) WKTabBarButton *selectedButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, assign) BOOL isCenter;
@end

@implementation WKTabBarView

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [[NSMutableArray alloc] init];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.isCenter = YES;
        // 添加加号按钮
        if (self.isCenter)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
            [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(sendStatus) forControlEvents:UIControlEventTouchUpInside];
            button.bounds = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
            [self addSubview:button];
            self.addButton = button;
        }
       
    }
    return self;
}

/**
 *  发微博
 */
- (void)sendStatus
{
    if ([self.delegate respondsToSelector:@selector(tabBarViewSendStatus:)]) {
        [self.delegate tabBarViewSendStatus:self];
    }
}

/**
 *  添加内部按钮
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    WKTabBarButton *button = [WKTabBarButton buttonWithType:UIButtonTypeCustom];
    
    // 设置数据
    button.item = item;
    
    // 添加点击事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:button];
    [self.tabBarButtons addObject:button];
    
    // 默认选中第0个按钮
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(WKTabBarButton *)button
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarView:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBarView:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    
    // 修改选中状态
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    self.selectedButton.selected = YES;
}

/**
 *  设置frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isCenter) {
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;
        self.addButton.center = CGPointMake(w * 0.5, h * 0.5);
        
        int count = (int)self.tabBarButtons.count;
        CGFloat buttonY = 0;
        CGFloat buttonW = w / self.subviews.count;
        CGFloat buttonH = h;
        for (int index = 0; index < count; index++) {
            WKTabBarButton *button = self.tabBarButtons[index];
            button.tag = index;
            
            CGFloat buttonX = index * buttonW;
            if (index > 1) {
                buttonX += buttonW;
            }
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        }
    }else{
   
    
    
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    
    // 按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.tabBarButtons.count; index++) {
        // 1.取出按钮
        WKTabBarButton *button = self.tabBarButtons[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
    }
}

@end
