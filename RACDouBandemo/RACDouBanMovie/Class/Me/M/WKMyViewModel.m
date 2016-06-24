//
//  WMMyViewModel.m
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/23.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKMyViewModel.h"

@interface WKMyViewModel()
@property (nonatomic,strong,readwrite) NSArray * dataArray;

@end

@implementation WKMyViewModel



- (NSArray *)dataArray{

    if (!_dataArray)
    {
        _dataArray = @[@[@{@"name":@"menhui222",@"image":@"me"}],
 
                       @[@{@"name":@"我订阅的书籍",@"image":@"icon_xx_sjtu"},
                         @{@"name":@"我收藏的音乐",@"image":@"icon_xx_bb"},
                         @{@"name":@"我喜欢的电影",@"image":@"icon_xx_ztlx"}],
                       ];
    }
    return _dataArray;
}

@end
