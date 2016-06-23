//
//  WKView.h
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/23.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKViewModelProtocol;

@protocol WKViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <WKViewModelProtocol>)viewModel;

- (void)yd_bindViewModel;
- (void)yd_setupViews;
- (void)yd_addReturnKeyBoard;

@end


@interface WKView : UIView

@end

