//
//  RootTabBarController.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/6.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = YES;
    
    [self createViewControllers];
    [self createViewShadowOnSliding];
}


- (void)createViewControllers {
    Class vcs[] = {[HomeViewController class], [TypeViewController class], [BrandViewController class], [TipsViewController class], [UserViewController class]};
    
    int vcsLength = sizeof(vcs)/sizeof(vcs[0]);
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithCapacity:vcsLength];
    for (int i = 0; i < vcsLength; i++) {
        Class class = vcs[i];
        MainViewController *vc = [[class alloc] init];
        vc.isShowTabBar = YES;
        MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:vc];
        [viewControllers addObject:nav];
    }
    
    self.viewControllers = viewControllers;
}

#pragma mark-

// 创建阴影效果
- (void)createViewShadowOnSliding {
    self.view.layer.shadowOpacity = 1.0f;
    self.view.layer.shadowRadius  = 15.0f;
    self.view.layer.shadowColor   = [UIColor blackColor].CGColor;
    self.view.layer.shadowPath    = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
}

@end
