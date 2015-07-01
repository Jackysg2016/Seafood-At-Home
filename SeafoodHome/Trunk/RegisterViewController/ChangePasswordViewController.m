//
//  ChangePasswordViewController.m
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "SFAPILoader.h"
#import "SVProgressHUD.h"
#import "WTRequestCenter.h"
#import "SIAlertView.h"

@interface ChangePasswordViewController ()
{
    NSString *_phoneNumber;
    NSString *_authCode;
    NSString *_ip;
    NSString *_password;
}
@end

@implementation ChangePasswordViewController

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber authCode:(NSString *)authCode IPAddress:(NSString *)IPAddress
{
    if (self = [super init]) {
        _phoneNumber = [phoneNumber copy];
        _authCode = [authCode copy];
        _ip = [IPAddress copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _phoneNumberLabel.text = _phoneNumber;
    self.view.backgroundColor = RGB(247,176,42);
}

// 确认按钮点击事件
- (IBAction)confirmBtnClicked:(UIButton *)sender
{
    NSString *errorMsg = nil;
    if (_newsPasswordTF.text.length == 0) {
        errorMsg = @"新密码不能为空";
    } else if (_confirmPasswordTF.text.length == 0) {
        errorMsg = @"确认密码不能为空";
    } else if (![_confirmPasswordTF.text isEqualToString:_newsPasswordTF.text]) {
        errorMsg = @"密码输入不一致";
    }
    
    if (errorMsg) {
        SIAlertView *alertView = [[SIAlertView alloc] init];
        alertView.title = @"错误提示";
        alertView.message = errorMsg;
        [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
        [alertView addButtonWithTitle:@"确认" type:SIAlertViewButtonTypeDestructive handler:nil];
        [alertView show];
    } else {
        [SVProgressHUD showWithStatus:@"正在修改密码..." maskType:SVProgressHUDMaskTypeClear];
        _password = [_newsPasswordTF.text copy];
        NSString *api = @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ChangePassword";
        NSDictionary *dict = @{@"username" : _phoneNumber, @"pwd" : _password, @"code" : _authCode};
        [WTRequestCenter postWithURL:api parameters:dict finished:^(NSURLResponse *response, NSData *data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if([dict[@"ret"] intValue] == 1) {
                [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
                return;
            }
            [SVProgressHUD dismiss];
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"找回密码成功，请亲牢记新密码！"];
            [alertView addButtonWithTitle:@"是的，我会" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            [alertView show];
        } failed:^(NSURLResponse *response, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"服务器很忙，请重试！"];
        }];
    }
}

@end
