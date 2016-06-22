//
//  APIHeader.h
//  RACIaskulogin
//
//  Created by 孟辉 on 16/6/13.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#ifndef APIHeader_h
#define APIHeader_h



#define kDomain @"https://api.douban.com/"


#define kJoinString(url)                [NSString stringWithFormat:@"%@/%@",kDomain,url]

#define kAPIURLMusicSearch                      kJoinString(@"v2/music/search")              //
#define kAPIURLBookSearch                      kJoinString(@"v2/book/search")


#define kAPIURLMovieSearch                      kJoinString(@"v2/movie/search")


#endif /* APIHeader_h */
