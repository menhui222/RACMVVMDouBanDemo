//
//  WKBookViewModel.m
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/16.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKBookViewModel.h"
#import "RMBook.h"

@implementation WKBookViewModel
- (instancetype)init
{
    if (self = [super init]) {
        _count = 10;
        _start = 0;
        _total = 0;
        [self mh_bindEvent];
    }
    return self;
}
- (void)mh_bindEvent{
    [self.requestCommad.executionSignals.switchToLatest subscribeNext:^(id x) {
        if ([x isKindOfClass:[NSError class]]) {
            return ;
        }
        RACTupleUnpack(NSMutableArray *array,NSNumber *total) = x;
        if (_start == 0) {
          self.dataArray =  array;
          self.total = [total intValue];
        }else{
            [self.dataArray addObjectsFromArray:array];
            self.total = [total intValue];
        }
        [self.updateUISubject sendNext:@(YES)];
 
    }];
    [self.requestCommad.executionSignals.switchToLatest subscribeNext:^(id x) {
        
    }];
    [self.subscriberComand.executionSignals.switchToLatest subscribeNext:^(id x) {
        
    }];
}
- (RACCommand *)requestCommad
{

    if (!_requestCommad)
    {
        _requestCommad = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            NSDictionary *params = @{@"q":@"都市",@"start":@(_start),@"count":@(_count)};
            
            return [[[[WKNetwork GET:kAPIURLBookSearch parameters:params] parsermodelArray:[Book class]] doNext:^(id x) {
                [MBProgressHUD showMessage:@"加载中..."];
            }] doCompleted:^{
                [MBProgressHUD hideHUD];
            }];
        }];
    }
    return _requestCommad;
}
- (RACCommand *)subscriberComand
{
    
    
    if (!_subscriberComand)
    {
        @weakify(self)
        
        _subscriberComand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(RACTuple *input) {
            RACTupleUnpack(NSNumber *row,NSNumber *selected) = input;
            NSLog(@"%@",input);
            @strongify(self)
            Book *book = self.dataArray[row.integerValue];
            
       
            if (selected.boolValue) {
             
                [kRealmManager transactionWithBlock:^{
                    [kRealmManager deleteObject:[RMBook objectForPrimaryKey:book.id]];
                }];
                book.isLocal = NO;
                }else{
              
                [kRealmManager transactionWithBlock:^{
                    [kRealmManager addOrUpdateObject:[RMBook rmbookWithBook:book]];
                }];
                    
                book.isLocal = YES;
                }
           
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@(YES)];
                [subscriber sendCompleted];
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }] ;
            
             
        }];
    }
    return _subscriberComand;
    
    
}
- (NSMutableArray *)dataArray
{

    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(RACSubject *)updateUISubject
{
    if (!_updateUISubject)
    {
        _updateUISubject = [RACSubject subject];
    }
    return _updateUISubject;





}
@end
