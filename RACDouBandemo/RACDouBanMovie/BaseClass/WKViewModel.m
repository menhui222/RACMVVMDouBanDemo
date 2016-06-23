//
//  WKViewModel.m
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/23.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKViewModel.h"

@implementation WKViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    WKViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel mh_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)mh_initialize {
}

@end
