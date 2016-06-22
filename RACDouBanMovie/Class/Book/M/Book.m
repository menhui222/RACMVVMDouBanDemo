//
//  Book.m
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/16.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "Book.h"
#import "RMBook.h"

@implementation Book
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"author":[NSString class]};
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}
- (void)mj_keyValuesDidFinishConvertingToObject
{
    if([RMBook objectForPrimaryKey:self.id])
    {
        self.isLocal = YES;
       // self.rmauthor = self.author.firstObject;
    }
  

}

+ (NSArray *)mj_ignoredPropertyNames
{
    return @[@"rmauthor",@"isLocal" ];
}
/*
+ (NSString *)primaryKey
{
    return @"id";
}
+ (NSArray *)ignoredProperties
{
    return @[@"author"];
}
 */
@end
