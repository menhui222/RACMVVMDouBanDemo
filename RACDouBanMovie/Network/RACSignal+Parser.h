//
//  AFHTTPSessionManager+ Parser.h
//  RACIaskulogin
//
//  Created by 孟辉 on 16/6/15.
//  Copyright © 2016年 孟辉. All rights reserved.
//


#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACSignal(Parser)

- (RACSignal *)parsermodelClass:(Class)modelClass;
- (RACSignal *)parsermodelArray:(Class)modelArray;
@end
