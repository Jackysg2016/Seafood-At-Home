//
//  MainNavigationController.m
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainNavigationController.h"

#define kBarTintColor RGB(247, 176, 42)
static NSString * const kBarBackgroundImangeNamed = @"main_nav_bar_bg";

@interface MainNavigationController ()<UINavigationControllerDelegate>

@end

@implementation MainNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI
{
    // 配置导航栏
    self.navigationBar.translucent = NO;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:kBarBackgroundImangeNamed] forBarMetrics:UIBarMetricsDefault];
    
    // 创建阴影
    NavigationBarShadowView *navigationBarShadowView = [NavigationBarShadowView navigationBarShadowView];
    [self.view addSubview:navigationBarShadowView];
}

@end
