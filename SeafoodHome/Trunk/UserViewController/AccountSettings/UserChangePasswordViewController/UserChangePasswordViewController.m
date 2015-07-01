//
//  UserChangePasswordViewController.m
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "UserChangePasswordViewController.h"
#import "SFConfigurationHandler.h"
#import "WTRequestCenter.h"
#import "SVProgressHUD.h"
#import "SIAlertView.h"
#import "SFUserDefaults.h"
#import <SFVCProtocol.h>

@interface UserChangePasswordViewController () <SFVCProtocol>
{
    NSString *_originallyPassword;
    NSString *_newPassowrd;
}
@end

@implementation UserChangePasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI {
    [self.UIHelper appendingNavTitleWithString:@"修改密码"];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    
    [SFConfigurationHandler setUserSubViewBottomButtonUI:_confirmBtn];
    self.scrollView.contentSize = CGSizeMake(0, 300.0f);

}

// 确认按钮点击事件
- (IBAction)confirmButtonClicked:(UIButton *)sender
{
    NSString *errorMsg = nil;
    if (_originallyPasswordTF.text.length == 0) {
        errorMsg = @"请填写原始密码！";
    } else if (_newsPasswordTF.text.length == 0) {
        errorMsg = @"请填写新密码！";
    } else if (_confirmPasswordTF.text.length == 0) {
        errorMsg = @"请填写确认密码！";
    } else if (![_newsPasswordTF.text isEqualToString:_confirmPasswordTF.text]) {
        errorMsg = @"两次输入的密码不一致，请检查！";
    } else if ([_newsPasswordTF.text isEqualToString:_originallyPasswordTF.text]) {
        errorMsg = @"原始密码和新密码不能相同！";
    }
    
    if (errorMsg) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"错误提示" andMessage:errorMsg];
        [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
        [alertView addButtonWithTitle:@"确认" type:SIAlertViewButtonTypeDestructive handler:nil];
        [alertView show];
    } else {
        [SVProgressHUD showWithStatus:@"请稍后"];
        _originallyPassword = [_originallyPasswordTF.text copy];
        _newPassowrd = [_newsPasswordTF.text copy];
        NSInteger userId = [[SFUserDefaults sharedUserDefaults] requestUserID];
        NSString *api = @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=UserChangePassword";
        NSDictionary *parameters = @{@"userId" : @(userId), @"newpwd" : _newPassowrd, @"oldpwd" :_originallyPassword};
        [WTRequestCenter postWithURL:api parameters:parameters finished:^(NSURLResponse *response, NSData *data) {
            NSDictionary *dict = JSON_TO_DICT(data);
            if ([dict[@"ret"] intValue] == 1) {
                [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
            } else if ([dict[@"ret"] intValue] == 0) {
                [SVProgressHUD dismiss];
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"修改密码成功，请牢记新密码！"];
                [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
                [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertView show];
            } else {
                [SVProgressHUD showErrorWithStatus:@"服务器很忙，请重试！"];
            }
        } failed:^(NSURLResponse *response, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"服务器很忙，请重试！"];
        }];
    }
}

@end
