//
//  WKTabBarView.h
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKTabBarView;

@protocol WKTabBarViewDelegate <NSObject>

@optional

- (void)tabBarView:(WKTabBarView *)tabBarView didSelectedButtonFrom:(int)from to:(int)to;

- (void)tabBarViewSendStatus:(WKTabBarView *)tabBarView;

@end

@interface WKTabBarView : UIView

@property (nonatomic, weak) id<WKTabBarViewDelegate> delegate;

/**
 *  添加按钮
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
