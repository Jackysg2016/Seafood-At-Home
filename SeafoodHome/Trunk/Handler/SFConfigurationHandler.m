//
//  SFConfigurationHandler.m
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "SFConfigurationHandler.h"

@implementation SFConfigurationHandler


+ (void)setUserSubViewBottomButtonUI:(UIButton *)button {
    // reset ui config
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES;
    button.backgroundColor = RGB(243,161,33);
    button.titleLabel.font = MyFont(16.0f);
}

+ (void)setUserSubViewRootScrollViewUI:(UIScrollView *)scrollView contentSizeHeight:(CGFloat)sizeHeight parentView:(UIView *)parentView {
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.alwaysBounceVertical = YES;
    scrollView.alwaysBounceHorizontal = NO;
    [scrollView setFrame:(CGRectMake(0, 0, parentView.width, parentView.height - 49))];
    [scrollView setContentSize:CGSizeMake(parentView.width, sizeHeight-49)];
}

@end
