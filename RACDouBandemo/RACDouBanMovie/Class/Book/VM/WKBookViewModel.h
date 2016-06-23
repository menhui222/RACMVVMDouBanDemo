//
//  WKBookViewModel.h
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/16.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKRefreshViewModel.h"
#import "Book.h"

@interface WKBookViewModel : WKRefreshViewModel




@property (nonatomic,strong)RACCommand *requestCommad;

@property (nonatomic ,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) RACCommand *subscriberComand;


@property (nonatomic,strong)RACSubject * updateUISubject;
@end
