//
//  LeftNavigationController.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftNavigationController.h"

#define kBarTintColor RGB(70, 70, 70)

static NSString * const kBackgroudImageNamed = @"left_view_bg";

@interface LeftNavigationController ()

@end

@implementation LeftNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self pushViewControllers];
    [self configurationNavigationBar];
    [self createShadowOnNavigationBar];
}

// 推入默认的视图控制器 —— LeftHomeViewController
- (void)pushViewControllers
{
    LeftHomeViewController *leftHomeVC = [[LeftHomeViewController alloc] init];
    self.viewControllers = @[leftHomeVC];
}

// 配置导航栏
- (void)configurationNavigationBar
{
    [self.navigationBar setBarStyle:UIBarStyleBlackOpaque]; 
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:kBackgroudImageNamed] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.tintColor = [UIColor groupTableViewBackgroundColor];
}

// 创建阴影
- (void)createShadowOnNavigationBar
{
    NavigationBarShadowView *shadow = [NavigationBarShadowView navigationBarShadowView];
    [self.view addSubview:shadow];
}

@end