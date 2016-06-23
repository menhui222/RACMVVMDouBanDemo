//
//  WKViewModel.h
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/23.
//  Copyright © 2016年 孟辉. All rights reserved.
//


#import <Foundation/Foundation.h>


@protocol WKViewModelProtocol <NSObject>

@optional
- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)mh_initialize;

@end


@interface WKViewModel : NSObject<WKViewModelProtocol>


@end


