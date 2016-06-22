//
//  Book.h
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/16.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm/Realm.h"

// 本来设计是本地存储模型和界面模型用一个的 但是很多问题1.Realm  对象属性不能是NSArray 而是RMLArray而且RMLArray里面必须放RLMObject类型 不能放NSString  2你如果RAC观察了某个属性就不能写入数据库
@interface Book :NSObject//RLMObject

@property (nonatomic, strong) NSString *alt;
@property (nonatomic, strong) NSString *alt_title;
@property (nonatomic, strong) NSArray  *author;
@property (nonatomic, strong) NSString *author_intro;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *publisher;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *id;


//@property (nonatomic, strong) RLMArray<RLMObject>*rmauthor;
@property (nonatomic, assign) BOOL isLocal;

@end

RLM_ARRAY_TYPE(Book)
/*
 {
 alt = "https://book.douban.com/subject/4202300/";
 "alt_title" = "";
 author =             (
 "可蕊"
 );
 "author_intro" = "可蕊，笔名：可蕊\n\n    星座：射手\n\n    爱好：爱看书、啃书、吃书、写书等\n\n    特长：记不住数字，包括自家的电话号码已发表作品：《都市妖奇谈》、《捉鬼实习生》、《龙之眼》等\n\n    座右铭：岂能尽如人意，但求无愧我心\n\n    最喜欢的食物：蘑菇、土豆和鸡肉\n\n    最喜欢的音乐：看书\n\n    作者自述：自认为是个比较迷糊的人，做事以慢半拍面闻名于朋友间。且因为脑细胞过多地分配给了文字，在数字方面极度缺乏，以至于常常忘记自己家的电话号码，所以常常感叹这辈子能做的事也就是码文字了。于是更加沉溺其中，乐不思蜀。九界原创网驻店作家。";
 binding = "平装";
 catalog = "章节壹  影之魅章节贰  民以食为天（新篇）章节叁  百年孤章节肆  女萝山鬼语相邀章节伍  巫咸之药章节陆  长生梦章节柒  帝流浆章节捌  给妖怪们的安全手册章节玫  我是猫章节拾  漫卷诗书番外  夜话";
 id = 4202300;
 image = "https://img3.doubanio.com/mpic/s6109684.jpg";
 images =             {
 large = "https://img3.doubanio.com/lpic/s6109684.jpg";
 medium = "https://img3.doubanio.com/mpic/s6109684.jpg";
 small = "https://img3.doubanio.com/spic/s6109684.jpg";
 };
 isbn10 = 7503939737;
 isbn13 = 9787503939730;
 "origin_title" = "";
 pages = 335;
 price = "29.80元";
 pubdate = "2009-12";
 publisher = "文化艺术出版社";
 rating =             {
 average = "8.7";
 max = 10;
 min = 0;
 numRaters = 714;
 };
 series =             {
 id = 14523;
 title = "都市妖奇谈";
 };
 subtitle = "";
 summary = "五百万人口的现代都市却住着三千多只妖怪？！\n它们隐藏在人类之中，甚至与你插肩而过！\n悄无声息地生存，捕食，进化……\n《山海经》、《搜神记》这些古籍中虚无缥缈的妖孽们都一一登场，出乎意料的是在他们身上，少了一份妖气，却多了一点人情味。\n《都市妖》的世界观非常清晰：神、仙、人、妖、怪、魑魅魍魉组成的世界看似等级分明，但却息息相关，仿佛一个巨大的食物链，彼此影响，彼此牵制，彼此依赖。一个一个看似独立去却又相互串连的小故事，仿佛多米多骨牌一样排列的谜题，解开一个又出现另一个，更让人从开始阅读就陷入欲罢不能的陷阱。";
 tags =             (
 {
 count = 177;
 name = "奇幻";
 title = "奇幻";
 },
 {
 count = 122;
 name = "可蕊";
 title = "可蕊";
 },
 {
 count = 88;
 name = "都市妖";
 title = "都市妖";
 },
 {
 count = 80;
 name = "小说";
 title = "小说";
 },
 {
 count = 67;
 name = "灵异";
 title = "灵异";
 },
 {
 count = 59;
 name = "玄幻";
 title = "玄幻";
 },
 {
 count = 42;
 name = "都市妖奇谈";
 title = "都市妖奇谈";
 },
 {
 count = 34;
 name = "轻小说";
 title = "轻小说";
 }
 );
 title = "都市妖奇谈";
 translator =             (
 );
 url = "https://api.douban.com/v2/book/4202300";
 },
 */