//
//  WKFormData.m
//  IflyAPP
//
//  Created by mac on 15/12/18.
//  Copyright © 2015年 iasku. All rights reserved.
//

#import "WKFormData.h"

@implementation WKFormData
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _filename = @"avatar.jpeg";
        _mimeType = @"image/jpeg";
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mineType
{
    self = [self init];
    if (self) {
        _data = data;
        _name = name;
        _filename = fileName;
        _mimeType = mineType;
    }
    return self;
}
@end
