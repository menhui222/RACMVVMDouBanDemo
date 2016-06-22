//
//  RACSignal+Request.m
//  RACIaskulogin
//
//  Created by 孟辉 on 16/6/15.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKNetwork+Request.h"
#import "WKNetwork.h"
@implementation WKNetwork(Request)
+ (RACSignal *)POST:(NSString *)URLString
         parameters:(NSDictionary*)parameters{

    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
        AFHTTPSessionManager *manager = [WKNetwork POST:URLString parameters:parameters success:^(id response) {
            
            if (!response) {
                [subscriber sendNext:[NSError errorWithDomain:@"没有数据" code:-1 userInfo:nil]];
                [subscriber sendCompleted];
                return ;
            }
           if ([response[@"code"] integerValue] != 0)
           {
                [subscriber sendNext:[NSError errorWithDomain:response[@"msg"] code:-1 userInfo:nil]];
                [subscriber sendCompleted];
                return ;
            }
            NSDictionary * json = response[@"result"];
            if (!json) {
                [subscriber sendNext:[NSError errorWithDomain:@"没有数据" code:-1 userInfo:nil]];
                [subscriber sendCompleted];
                return ;
            }
          if ([response[@"code"] integerValue] == 0) {
            [subscriber sendNext:response[@"result"]];
            [subscriber sendCompleted];
          }
        } failure:^(NSError *error) {
            [subscriber sendNext:error];
            [subscriber sendCompleted];
        }];
        //  当信号销毁 是 接口也会Cancel
        return [RACDisposable disposableWithBlock:^{
            [manager invalidateSessionCancelingTasks:YES];
        }];
    }];
    return signal;

}


+ (RACSignal *)GET:(NSString *)URLString
         parameters:(NSDictionary*)parameters{
    
     RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
         
      AFHTTPSessionManager *manager = [WKNetwork GET:URLString parameters:parameters success:^(NSDictionary* response) {
            
            if (!response) {
                [subscriber sendNext:[NSError errorWithDomain:@"没有数据" code:-1 userInfo:nil]];
                [subscriber sendCompleted];
                return ;
            }
        
          
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            
        } failure:^(NSError *error) {
            [subscriber sendNext:error];
            [subscriber sendCompleted];
        }] ;
         //  当信号销毁 是 接口也会Cancel
        return [RACDisposable disposableWithBlock:^{
            [manager invalidateSessionCancelingTasks:YES];
        }];
}];
return signal;

}
@end
