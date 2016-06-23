//
//  WKRefreshViewModel.h
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/23.
//  Copyright © 2016年 孟辉. All rights reserved.
//
typedef enum : NSUInteger {
    WKHeaderRefresh_HasMoreData = 1,
    WKHeaderRefresh_HasNoMoreData,
    WKFooterRefresh_HasMoreData,
    WKFooterRefresh_HasNoMoreData,
    WKRefreshError,
    //WKRefreshUI,
} WKRefreshDataStatus;

#import "WKViewModel.h"

@protocol WKRefreshViewModel <NSObject>


@end

@interface WKRefreshViewModel : WKViewModel

@property (nonatomic,assign,readonly)int start;
@property (nonatomic,assign,readonly)int count;
@property (nonatomic,assign)int total;
//@property (nonatomic,assign, readonly)WKRefreshDataStatus refreshDataStatus;

- (void)pageDown;

- (void)startPage;
@end
