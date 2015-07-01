//
//  LeftViewTelphonePopupView.m
//  SeafoodHome
//
//  Created by btw on 14/12/16.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewTelphonePopupView.h"

@implementation LeftViewTelphonePopupView

+ (instancetype)leftViewTelphonePopupViewWithFrame:(CGRect)frame delegate:(id<LeftViewTelphonePopupViewDelegate>)delegate
{
    LeftViewTelphonePopupView *popupView = SELF_NIB;
    popupView.frame = frame;
    popupView.delegate = delegate;
    return popupView;
}

- (void)awakeFromNib
{
    // configuration self
    self.firstTelLabel.tag = 0;
    self.secondTelLabel.tag = 1;
    self.alpha = 0.0f;
    
    // 为Telphone Label添加手势
    NSArray *views = @[self.firstTelLabel, self.secondTelLabel];
    for (int i = 0; i<views.count; i++)
    {
        [views[i] setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(telphoneLabelTaped:)];
        [[views objectAtIndex:i] addGestureRecognizer:tap];
    }
}

- (void)setDelegate:(id<LeftViewTelphonePopupViewDelegate>)delegate {
    _delegate = delegate;
    
    if (!_webView) {
        // 初始化WebView
        _webView = [[UIWebView alloc] init];
        UIViewController *vc = (UIViewController *)_delegate;
        [vc.view addSubview:_webView];
    }
}

// Telphone Label Tap Action
- (void)telphoneLabelTaped:(UITapGestureRecognizer *)recognizer
{
    UILabel *label = (UILabel *)recognizer.view;
    [_delegate leftViewTelphonePopupView:self telLabelTap:label labelIndex:(int)recognizer.view.tag];
    
    // 拨打电话
    NSString *telStr = [@"tel://" stringByAppendingString:label.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:telStr]];
    [_webView loadRequest:request];
}

- (void)showTelphonePopupView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0f;
    }];
}

- (void)hideTelphonePopupView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0f;
    }];
}

@end
