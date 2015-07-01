//
//  RegisterAndLoginNavController.m
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "UserPrefixNavController.h"
#import "LoginViewController.h"

@interface UserPrefixNavController ()

@end

@implementation UserPrefixNavController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
    
    // 状态栏
    UIView *statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    statusBar.backgroundColor = RGB(247,176,42);
    [self.view addSubview:statusBar];
    
    // 默认推入这个登陆视图控制器
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self pushViewController:vc animated:NO];
    
}

@end
