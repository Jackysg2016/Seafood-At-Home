//
//  RegisterViewController.m
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ResetPasswordViewController.h"
#import "RegExpValidate.h"
#import "SVProgressHUD.h"
#import "WTRequestCenter.h"
#import "SIAlertView.h"
#import "SFUserDefaults.h"
#import "WindowRootViewController.h"

@interface LoginViewController () {
    NSString *_phoneNumber;
    NSString *_password;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGB(247,176,42);
}


// 忘记密码按钮点击事件
- (IBAction)forgetThePasswordButtonClicked:(UIButton *)forgetThePassword {
    ResetPasswordViewController *vc = [[ResetPasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 注册按钮点击事件
- (IBAction)registerButtonClicked:(UIButton *)sender {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 登陆按钮点击事件
- (IBAction)loginButtonClicked:(UIButton *)sender
{
    NSString *errorMsg = nil;
    if (_phoneNumberTF.text.length == 0) {
        errorMsg = @"手机号码（账号）不能为空！";
    } else if (_passwordTF.text.length == 0) {
        errorMsg = @"密码不能为空！";
    } else if (![RegExpValidate validateMobile:_phoneNumberTF.text]) {
        errorMsg = @"手机号码格式错误";
    }

    if (errorMsg) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"错误提示" andMessage:errorMsg];
        [alertView addButtonWithTitle:@"确认" type:SIAlertViewButtonTypeDestructive handler:nil];
        [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
        [alertView show];
    } else {
        _phoneNumber = [_phoneNumberTF.text copy];
        _password = [_passwordTF.text copy];
        [SVProgressHUD showWithStatus:@"正在验证..." maskType:SVProgressHUDMaskTypeClear];
//        NSString *api = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=Login&userName=%@&pwd=%@", _phoneNumber, _password];
        NSString *api = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=Login"];
        NSDictionary *dict = @{@"userName" : _phoneNumber, @"pwd" : _password};
        [WTRequestCenter postWithURL:api parameters:dict finished:^(NSURLResponse *response, NSData *data) {
            [SVProgressHUD dismiss];
            NSDictionary *dict = JSON_TO_DICT(data);
            NSLog(@"%@", dict);
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:nil];
            [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
            if (!dict[@"ret"]) {
                [alertView addButtonWithTitle:@"确认" type:SIAlertViewButtonTypeDestructive handler:nil];
                alertView.message = @"服务器很忙，请重试！";
            } else if([dict[@"ret"] intValue] == 1) {
                [alertView addButtonWithTitle:@"确认" type:SIAlertViewButtonTypeDestructive handler:nil];
                alertView.message = @"登陆失败，请检查账号和密码是否正确！";;
            } else if ([dict[@"ret"] intValue] == 0){
                alertView.message = @"登陆成功，欢迎您再次来到海鲜到家！";
                [[SFUserDefaults sharedUserDefaults] setUserInfoWithDictionary:dict[@"result"]];
                [[SFUserDefaults sharedUserDefaults] requestNetworkingShoppingCarCount];
                [alertView addButtonWithTitle:@"确认" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView){
                    if (_isFromFirstVC) {
                        WindowRootViewController *rootVC = [[WindowRootViewController alloc] init];
                        rootVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                        [self presentViewController:rootVC animated:YES completion:nil];
                    } else {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                }];
            }
            [alertView show];
        } failed:^(NSURLResponse *response, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"服务器很忙，请重试！"];
        }];
    }
}

// 返回按钮点击事件
- (IBAction)backButtonClicked:(UIButton *)sender {
    if (self.navigationController.viewControllers.count <= 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
