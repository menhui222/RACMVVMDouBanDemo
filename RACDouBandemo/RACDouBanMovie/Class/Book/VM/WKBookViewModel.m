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
        
    }
    return self;
}
- (void)mh_initialize{
    
    [self mh_bindEvent];
}
- (void)mh_bindEvent{
    [self.requestCommad.executionSignals.switchToLatest subscribeNext:^(id x) {
        if ([x isKindOfClass:[NSError class]]) {
            [self.updateUISubject sendNext:@(WKRefreshError)];
            return ;
        }
        RACTupleUnpack(NSMutableArray *array,NSNumber *total) = x;
        if (self.start == 0) {
          self.dataArray =  array;
          self.total = [total intValue];
            if (self.total == self.dataArray.count||self.dataArray.count == 0) {
                [self.updateUISubject sendNext:@(WKHeaderRefresh_HasNoMoreData)];
            }else{
             
                [self.updateUISubject sendNext:@(WKHeaderRefresh_HasMoreData)];
            }
           
        }else{
            [self.dataArray addObjectsFromArray:array];
            self.total = [total intValue];
            if (self.total == self.dataArray.count) {
                [self.updateUISubject sendNext:@(WKFooterRefresh_HasNoMoreData)];
            }else{
                [self.updateUISubject sendNext:@(WKFooterRefresh_HasMoreData)];
            }
            
        }
    }];
    
    [self.subscriberComand.executionSignals.switchToLatest subscribeNext:^(id x) {
        
    }];
}
- (RACCommand *)requestCommad
{

    if (!_requestCommad)
    {
        @weakify(self)
        _requestCommad = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            NSDictionary *params = @{@"q":@"都市",@"start":@(self.start),@"count":@(self.count)};
            [MBProgressHUD showMessage:@"加载中..."];
            return [[[WKNetwork GET:kAPIURLBookSearch parameters:params] parsermodelArray:[Book class]] doNext:^(id x) {
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
            }];
            
             
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
