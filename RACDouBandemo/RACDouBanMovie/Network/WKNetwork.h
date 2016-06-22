//
//  WKNetwork.h
//  RACIaskulogin
//
//  Created by 孟辉 on 16/6/13.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKFormData.h"
#import "AFNetworking.h"

@protocol WKJSONConvertType <NSObject>

@optional
+ (id)fromJson:(id)json;
+ (NSMutableArray *)fromArrayJson:(id)json;
@end


@interface WKNetwork : NSObject


/**
 *功能: 创建WKNetwork的对象方法
 */
+ (instancetype)request;

+ (AFHTTPSessionManager *)POST:(NSString *)URLString
                        parameters:(NSDictionary*)parameters
                           success:(void (^)(id response))success
                           failure:(void (^)(NSError *error))failure;

+ (AFHTTPSessionManager *)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(void (^)( id ))success
    failure:(void (^)(NSError *))failure;


+ (AFHTTPSessionManager *)POST:(NSString *)URLString
                   parameters:(NSDictionary*)parameters formDataArray:(NSArray<WKFormData*>*)formDataArray
                      success:(void (^)( id ))success
                      failure:(void (^)(NSError *))failure;
@end
