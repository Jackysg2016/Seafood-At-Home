//
//  LeftViewFooterView.m
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewFooterView.h"

static NSString * const kBackgroundImageNamed = @"left_view_footer_bar_bg";

@implementation LeftViewFooterView

+ (instancetype)leftViewFooterViewWithFrame:(CGRect)frame
{
    LeftViewFooterView *view = SELF_NIB;
    view.frame = frame;
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundImageNamed]];
    return view;
}

@end