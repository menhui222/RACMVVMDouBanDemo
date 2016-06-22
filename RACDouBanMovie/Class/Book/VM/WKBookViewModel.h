//
//  WKBookViewModel.h
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/16.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface WKBookViewModel : NSObject


@property (nonatomic,assign)int start;
@property (nonatomic,assign)int count;
@property (nonatomic,assign)int total;

@property (nonatomic,strong)RACCommand *requestCommad;

@property (nonatomic ,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) RACCommand *subscriberComand;


@property (nonatomic,strong)RACSubject * updateUISubject;
@end
