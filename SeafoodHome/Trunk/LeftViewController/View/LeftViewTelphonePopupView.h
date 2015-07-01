//
//  LeftViewTelphonePopupView.h
//  SeafoodHome
//
//  Created by btw on 14/12/16.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftViewTelphonePopupView;

@protocol LeftViewTelphonePopupViewDelegate <NSObject>

- (void)leftViewTelphonePopupView:(LeftViewTelphonePopupView *)telphonePopupView telLabelTap:(UILabel *)telLabel labelIndex:(int)labelIndex;

@end

@interface LeftViewTelphonePopupView : UIView

@property (weak, nonatomic) IBOutlet UILabel *firstTelLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTelLabel;

@property (assign, nonatomic) id<LeftViewTelphonePopupViewDelegate> delegate;
@property (strong, nonatomic) UIWebView *webView;

+ (instancetype)leftViewTelphonePopupViewWithFrame:(CGRect)frame delegate:(id<LeftViewTelphonePopupViewDelegate>)delegate;

- (void)showTelphonePopupView;
- (void)hideTelphonePopupView;

@end
