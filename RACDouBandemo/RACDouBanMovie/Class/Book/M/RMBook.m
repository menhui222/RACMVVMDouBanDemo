//
//  RMBook.m
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/17.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "RMBook.h"
#import "Book.h"

@implementation RMBook

- (instancetype)initWithBook:(Book *)book
{
    self = [super init];
    if (self) {
        self.alt = book.alt;
        self.alt_title = book.alt;
        self.author = book.author.firstObject;
        self.author_intro = book.author_intro;
        self.summary = book.summary;
        self.publisher = book.publisher;
        self.title = book.title;
        self.image = book.image;
        self.id= book.id;
    }
    return self;
}

+ (instancetype)rmbookWithBook:(Book *)book
{
    return [[self alloc] initWithBook:book];
}
+ (NSString *)primaryKey
{
    return @"id";
}


// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
