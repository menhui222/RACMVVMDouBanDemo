//
//  WKBookTableViewCell.m
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/16.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKBookTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation WKBookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.subscriberBtn.layer.cornerRadius = 4;
        self.subscriberBtn.layer.masksToBounds = true;
    self.subscriberBtn.layer.borderColor = kSujectColor.CGColor;
    self.subscriberBtn.layer.borderWidth = 1;
}
- (void)setModel:(Book *)book{
    self.titleLabel.text = book.title;
    self.authorLabel.text = book.author.firstObject;
    self.summaryLabel.text = book.summary;
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:book.image]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
