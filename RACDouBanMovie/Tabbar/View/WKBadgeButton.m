//
//  WKBadgeButton.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKBadgeButton.h"
#import "UIImage+Extend.h"

#define WKBadgeButtonTitleSize 11.0

@implementation WKBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.hidden = YES;
        self.titleLabel.font = [UIFont systemFontOfSize:WKBadgeButtonTitleSize];
        [self setBackgroundImage:[UIImage resizedImageWithName:@"tabbar_badge"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    self.hidden = !(BOOL)self.badgeValue;
    
    if (self.badgeValue) {
        // 设置数据
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        // 文字尺寸
        CGSize titleSize = [badgeValue sizeWithFont:[UIFont systemFontOfSize:WKBadgeButtonTitleSize]];
        frame.size.width = MAX(badgeW, titleSize.width + 10);
        frame.size.height = badgeH;
        self.frame = frame;
       
    }
}

@end
