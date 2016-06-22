//
//  UIImage+Extend.m
//  RYIaskuTest
//
//  Created by 孟辉 on 16/4/18.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

+ (instancetype)resizedImageWithName:(NSString *)imageName
{
    return [self resizedImageWithName:imageName width:0.5 height:0.5];
}

+ (instancetype)resizedImageWithName:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * width
                                      topCapHeight:image.size.height * height];
}

@end
