//
//  AFHTTPSessionManager+ Parser.m
//  RACIaskulogin
//
//  Created by 孟辉 on 16/6/15.
//  Copyright © 2016年 孟辉. All rights reserved.
//


#import "RACSignal+Parser.h"


@implementation RACSignal(Parser)
- (RACSignal *)parsermodelClass:(Class)modelClass{
    

    RACSignal * signal = [self map:^id(id value) {
        NSLog(@"%@",value);
        if ([value isKindOfClass:[NSError class]]) {
            return value;
        }
        return [modelClass mj_objectWithKeyValues:value];
    }];
                          
    
    return signal;
    
}
- (RACSignal *)parsermodelArray:(Class)modelArray{
    
    RACSignal * signal = [self map:^id(id value) {
        if ([value isKindOfClass:[NSError class]]) {
            return value;
        }
        NSString *key =[[NSString stringWithFormat:@"%@s",NSStringFromClass(modelArray)] mj_firstCharLower];
        if (!value[key]) {
           return [NSError errorWithDomain:@"数据为空" code:-1 userInfo:nil];
        }
        int total = value[@"total"] ? [value[@"total"] intValue]:0;
        return RACTuplePack([modelArray mj_objectArrayWithKeyValuesArray:value[key]],@(total));
        
    }];
    
    
    return signal;
    
}
@end
