//
//  RACSignal+Request.h
//  RACIaskulogin
//
//  Created by 孟辉 on 16/6/15.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "WKNetwork.h"

@interface WKNetwork(Request)
+ (RACSignal *)POST:(NSString *)URLString
         parameters:(NSDictionary*)parameters;
+ (RACSignal *)GET:(NSString *)URLString
        parameters:(NSDictionary*)parameters;
@end
