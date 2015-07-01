//
//  ResetPasswordViewController.m
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ChangePasswordViewController.h"
#import "SFAPILoader.h"
#import "RegExpValidate.h"
#import "SVProgressHUD.h"
#import "WTRequestCenter.h"
#import "SIAlertView.h"

@interface ResetPasswordViewController ()
{
    IBOutlet UIButton *requestAuthCodeButton;
    NSString *_authCode;
    NSString *_phoneNumber;
    NSString *_ip;
}
@end

@implementation ResetPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGB(247,176,42);
    [requestAuthCodeButton.titleLabel adjustsFontSizeToFitWidth];

    [SVProgressHUD showWithStatus:@"正在获取您的IP地址" maskType:SVProgressHUDMaskTypeGradient];
    [SFAPILoader loadDataWithURLString:[API APIOfIPAddress] success:^(NSDictionary *responseDict) {
        _ip = [responseDict[@"ip"] copy];
        [SVProgressHUD dismiss];
    } error:^{
        [SVProgressHUD showErrorWithStatus:@"获取失败，请勿注册"];
    } alway:nil];

}

// 获取验证码按钮点击事件
- (IBAction)authCodeButtonClicked:(UIButton *)sender
{
    if ([RegExpValidate validateMobile:_phoneNumberTF.text]) {
        _phoneNumber = [_phoneNumberTF.text copy];
        
        // 申请验证码
        NSString *api = @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=SelectCode";
        NSDictionary *dict = @{@"userName" : _phoneNumber, @"ipaddress" : _ip, @"type" : @1};
        
        [SVProgressHUD showWithStatus:@"正在获取验证码"];
        [WTRequestCenter postWithURL:api parameters:dict finished:^(NSURLResponse *response, NSData *data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([dict[@"ret"] intValue] == 1) {
                [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
                return;
            }
            NSLog(@"%@", dict);
            _authCode = [dict[@"result"][@"code"] stringValue];
            
            [SVProgressHUD showSuccessWithStatus:@"验证码已经发送到您的手机，请留意您的手机短信。"];
            
            // 开始倒数
            requestAuthCodeButton.userInteractionEnabled = NO;
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
        } failed:^(NSURLResponse *response, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"服务器正在忙！请重新尝试"];
        }];
    } else {
        if (_phoneNumberTF.text.length == 0)
        {
            [self showErrorMsg:@"请先填写手机号码"];
        } else {
            [self showErrorMsg:@"请检查填写的手机号码是否正确。"];
        }
    }
}

// 确认密码按钮点击事件
- (IBAction)confirmButtonClicked:(UIButton *)sender
{
    BOOL isOK = YES;
    if (_ip == nil) {
        [self showErrorMsg:@"IP地址获取失败，无法注册！"];
        isOK = NO;
    } else if (_phoneNumberTF.text.length == 0) {
        [self showErrorMsg:@"请先填写需要找回密码的账号（手机号码）"];
        isOK = NO;
    } else if (_phoneNumber == nil) {
        [self showErrorMsg:@"请先获取验证码！"];
        isOK = NO;
    } else if (![_phoneNumber isEqualToString:_phoneNumberTF.text]) {
        [self showErrorMsg:@"请勿修改获取验证码后的手机号码，若是这样，需要重新获取验证码！"];
        isOK = NO;
    } else if (_authCodeTF.text.length == 0) {
        [self showErrorMsg:@"还没填写验证码，请您先获取验证码再填写！"];
        isOK = NO;
    } else if (![_authCode isEqualToString:_authCodeTF.text]) {
        [self showErrorMsg:@"填写的验证码不对，请仔细查看手机的短信！"];
        isOK = NO;
    }
    
    if (isOK) {
        NSLog(@"%@ %@ %@", _phoneNumber, _authCode, _ip);
        ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] initWithPhoneNumber:_phoneNumber authCode:_authCode IPAddress:_ip];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 返回按钮点击事件
- (IBAction)backButtonClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showErrorMsg:(NSString *)msg {
    SIAlertView *alertView = [[SIAlertView alloc] init];
    alertView.title = @"错误提示";
    [alertView addButtonWithTitle:@"确认" type:SIAlertViewButtonTypeDestructive handler:nil];
    [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
    alertView.message = msg;
    [alertView show];
}

- (void)showSuccessMsg:(NSString *)msg {
    SIAlertView *alertView = [[SIAlertView alloc] init];
    alertView.title = @"温馨提示";
    [alertView addButtonWithTitle:@"确认" type:SIAlertViewButtonTypeDestructive handler:nil];
    [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
    alertView.message = msg;
    [alertView show];
}

// 倒计时
- (void)countDown:(NSTimer *)timer {
    static int second = 60;
    [requestAuthCodeButton setTitle: [NSString stringWithFormat:@"%d秒后重新获取", second] forState:UIControlStateNormal];
    if (second == 0) {
        [requestAuthCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        requestAuthCodeButton.userInteractionEnabled = YES;
        second = 60;
        [timer invalidate];
    }
    second --;
}

@end
