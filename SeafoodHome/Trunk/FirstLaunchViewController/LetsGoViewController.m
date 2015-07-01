//
//  LetsGoViewController.m
//  SeafoodHome
//
//  Created by btw on 15/2/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "LetsGoViewController.h"
#import "WindowRootViewController.h"
#import "LoginViewController.h"

@interface LetsGoViewController ()

@end

@implementation LetsGoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGB(247,176,42);
    [self configBorderWithButton:_loginOrRegisterBtn];
    [self configBorderWithButton:_letsGoBtn];
}

- (void)configBorderWithButton:(UIButton *)button {
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES;
}

- (IBAction)loginOrRegisterBtnClicked:(UIButton *)sender {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.isFromFirstVC = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)letsGoBtnClicked:(UIButton *)sender {
    WindowRootViewController *rootVC = [[WindowRootViewController alloc] init];
    rootVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:rootVC animated:YES completion:nil];
}
@end
