//
//  NavigationBarShadowView.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "NavigationBarShadowView.h"

static NSString *kShadowImageNamed = @"top_to_down_shadow";

@implementation NavigationBarShadowView

+ (instancetype)navigationBarShadowView
{
    NavigationBarShadowView *navigationBarShadowView = [[NavigationBarShadowView alloc] initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT + NavigationBar_HEIGHT, SCREEN_WIDTH, 9.5)];
    return navigationBarShadowView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kShadowImageNamed]];
    }
    return self;
}

@end
