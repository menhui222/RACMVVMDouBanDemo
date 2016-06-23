//
//  WKRefreshViewModel.m
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/23.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKRefreshViewModel.h"
@interface WKRefreshViewModel()

@end

@implementation WKRefreshViewModel


- (instancetype)init
{
    if (self = [super init]) {
        _count = 10;
        _start = 0;
        _total = 0;
    }
    return self;
}
- (void)startPage{

    _start = 0;
}

- (void)pageDown{
    
   _start ++;
}
@end
