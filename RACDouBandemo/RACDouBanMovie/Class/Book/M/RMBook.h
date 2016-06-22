//
//  RMBook.h
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/17.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <Realm/Realm.h>
@class Book;
@interface RMBook : RLMObject
@property (nonatomic, strong) NSString *alt;
@property (nonatomic, strong) NSString *alt_title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *author_intro;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *publisher;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *id;



+ (instancetype)rmbookWithBook:(Book *)book;
@end



// This protocol enables typed collections. i.e.:
// RLMArray<RMBook>
RLM_ARRAY_TYPE(RMBook)
