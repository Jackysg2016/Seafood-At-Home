//
//  DefaultNavigationBarView.m
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DefaultNavigationBarView.h"

static NSString * kBackgroundImageNamed = @"default_navbar_bg";

@implementation DefaultNavigationBarView

+ (instancetype)defaultNavigationBarViewWithFrame:(CGRect)frame
{
    CGRect newRect = frame;
    newRect.size.height = 63;
    
    DefaultNavigationBarView *defaultNavigationBarView = [[DefaultNavigationBarView alloc] initWithFrame:newRect];
    return defaultNavigationBarView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super init])
    {
        [self createBackground];
    }
    return self;
}

- (void)createBackground
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundImageNamed]];
}

- (void)createSearchTextField
{
}

@end
