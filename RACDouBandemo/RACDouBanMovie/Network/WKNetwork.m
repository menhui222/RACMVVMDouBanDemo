//
//  WKNetwork.m
//  RACIaskulogin
//
//  Created by 孟辉 on 16/6/13.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKNetwork.h"


@implementation WKNetwork

+ (instancetype)request {
    static WKNetwork *network = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[self alloc] init];
    });
    return network;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (AFHTTPSessionManager *)POST:(NSString *)URLString
                        parameters:(NSDictionary*)parameters
                           success:(void (^)(id response))success
                           failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *operationManager = [AFHTTPSessionManager manager];
    
    [operationManager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    return operationManager;

   
}

+ (AFHTTPSessionManager *)GET:(NSString *)URLString
                       parameters:(NSDictionary*)parameters
                          success:(void (^)( id ))success
                          failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *operationManager = [AFHTTPSessionManager manager];
    
    [operationManager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    return operationManager;

}


+ (AFHTTPSessionManager *)POST:(NSString *)URLString
                   parameters:(NSDictionary*)parameters formDataArray:(NSArray<WKFormData*>*)formDataArray
                      success:(void (^)( id ))success
                      failure:(void (^)(NSError *))failure{
    
    
    AFHTTPSessionManager *operationManager = [AFHTTPSessionManager manager];
    
    [operationManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (WKFormData *_formData in formDataArray) {
            [formData appendPartWithFileData:_formData.data name:_formData.name fileName:_formData.filename mimeType:_formData.mimeType];
            NSLog(@"formData.name%@,  formData.lenth%lu",_formData.name,(unsigned long)_formData.data.length);
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure(error);
    }];
    
    return operationManager;
}










@end
