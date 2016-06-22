//
//  WKTabBarButton.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKTabBarButton.h"
#import "WKBadgeButton.h"
// 获取RGB颜色
#define WKColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 内部图片所占比例
#define WKTabBarButtonImageRatio 0.7
// 内部文字大小
#define WKTabBarButtonTitleSize 10.0

// 文字颜色
#define WKTabBarButtonTitleColor WKColor(117, 117, 117)
#define WKTabBarButtonTitleSelColor    kSujectColor

@interface WKTabBarButton ()
/**
 *  提醒数字按钮
 */
@property (nonatomic, strong) WKBadgeButton *badgeButton;

@end

@implementation WKTabBarButton

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置内部图片和文字格式
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:WKTabBarButtonTitleSize];
        [self setTitleColor:WKTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:WKTabBarButtonTitleSelColor forState:UIControlStateSelected];
        
        // 添加提醒数字按钮
        WKBadgeButton *badgeButton = [[WKBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // KVO 监听item属性的改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

/**
 *  监听到某个对象的属性值改变了 就会调用
 *
 *  @param keyPath 属性名
 *  @param object  对象名
 *  @param change  属性的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置badgeValue
    self.badgeButton.badgeValue = self.item.badgeValue;
    // 设置提醒数字按钮frame
    CGRect frame = self.badgeButton.frame;
    CGFloat left =  [UIScreen mainScreen].bounds.size.width == 320 ?0.15*frame.size.width:0.4*frame.size.width;
    CGFloat badgeX = self.frame.size.width - frame.size.width - left;
    CGFloat badgeY = 0;
    frame.origin.x = badgeX;
    frame.origin.y = badgeY;
    self.badgeButton.frame = frame;
}

#pragma mark - 重置按钮格式

// 去除按钮高亮状态
- (void)setHighlighted:(BOOL)highlighted {}

// 重写内部图片frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * WKTabBarButtonImageRatio;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

// 重写内部文字frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height * WKTabBarButtonImageRatio - 5;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
