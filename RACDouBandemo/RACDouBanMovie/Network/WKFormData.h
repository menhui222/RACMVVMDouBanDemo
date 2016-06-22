//
//  WKFormData.h
//  IflyAPP
//
//  Created by mac on 15/12/18.
//  Copyright © 2015年 iasku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKFormData : NSObject
/**
 *  用来封装文件数据的模型
 */

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

- (instancetype)initWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mineType;

@end
