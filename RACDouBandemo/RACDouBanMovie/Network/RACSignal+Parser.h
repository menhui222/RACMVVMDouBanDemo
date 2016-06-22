//
//  AFHTTPSessionManager+ Parser.h
//  RACIaskulogin
//
//  Created by 孟辉 on 16/6/15.
//  Copyright © 2016年 孟辉. All rights reserved.
//


#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACSignal(Parser)

/**
 *  解析一个对象
 *
 *  @param modelClass 类名
 *
 *  @return 信号
 */
- (RACSignal *)parsermodelClass:(Class)modelClass;
/**
 *  解析一个数组
 *
 *  @param modelArray 类名
 *
 *  @return 信号
 */
- (RACSignal *)parsermodelArray:(Class)modelArray;
@end
