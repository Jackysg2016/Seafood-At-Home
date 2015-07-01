//
//  UserChangeInfoViewController.m
//  SeafoodHome
//
//  Created by btw on 14/12/26.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "UserChangeInfoViewController.h"
#import "SFConfigurationHandler.h"
#import "SIAlertView.h"
#import "WTRequestCenter.h"
#import "SVProgressHUD.h"
#import "SFUserDefaults.h"
#import "RegExpValidate.h"
#import "SFVCProtocol.h"

@interface UserChangeInfoViewController () <SFVCProtocol>
{
    NSString *_realName;
    NSString *_phoneNumber;
    NSString *_mail;
    NSString *_address;
}
@end

@implementation UserChangeInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
    [self createData];
}

- (void)createUI {
    [self.UIHelper appendingNavTitleWithString:@"修改个人信息"];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    
    // reset ui config
    [SFConfigurationHandler setUserSubViewBottomButtonUI:_confirmBtn];
    [_confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.scrollView.contentSize = CGSizeMake(0, 435.0f);

}

- (void)createData {
    NSDictionary *userInfo = [[SFUserDefaults sharedUserDefaults] requestUserInfo];
    _changeUserNameTF.text = userInfo[kUserInfoKeyRealName];
    _changeAddressTF.text = userInfo[kUserInfoKeyAddress];
    _changeMailTF.text = userInfo[kUserInfoKeyEmail];
    _changePhoneNumberTF.text = userInfo[kUserInfoKeyPhoneNumber];
}

// 确定按钮点击事件
- (void)confirmBtnClicked:(UIButton *)button
{
    NSString *errorMsg = nil;
    if (_changeUserNameTF.text.length == 0) {
        errorMsg = @"联系人姓名不能为空！";
    } else if (_changePhoneNumberTF.text.length == 0) {
        errorMsg = @"请填写手机号码！";
    } else if (![RegExpValidate validateMobile:_changePhoneNumberTF.text]) {
        errorMsg = @"手机号码格式不正确！";
    } else if (_changeMailTF.text.length !=0 && ![RegExpValidate validateEmail:_changeMailTF.text]) {
        errorMsg = @"电子邮箱地址不正确！";
    } else if (_changeAddressTF.text.length == 0) {
        errorMsg = @"请填写收货地址！";
    }
    
    if (errorMsg) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"错误提示" andMessage:errorMsg];
        [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:nil];
        [alertView show];
    } else {
        [SVProgressHUD showWithStatus:@"请稍候..."];
        _realName = [_changeUserNameTF.text copy];
        _phoneNumber = [_changePhoneNumberTF.text copy];
        _mail = [_changeMailTF.text copy];
        _address = [_changeAddressTF.text copy];
        // 修改个人信息
        NSString *api = @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ChangeUserInformation";
        NSInteger userId = [[SFUserDefaults sharedUserDefaults] requestUserID];
        NSDictionary *parameters = @{
                                     kUserInfoKeyLogined : @(YES),
                                     kUserInfoKeyUserID: @(userId),
                                     kUserInfoKeyPhoneNumber:_phoneNumber,
                                     kUserInfoKeyRealName:_realName,
                                     kUserInfoKeyAddress :_address,
                                     kUserInfoKeyEmail:_mail
                                     };
        
        if([parameters isEqualToDictionary:[[SFUserDefaults sharedUserDefaults] requestUserInfo]]) {
            [SVProgressHUD dismiss];
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"信息基本相同，无需修改了吧！"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertView show];
        } else {
            [WTRequestCenter postWithURL:api parameters:parameters finished:^(NSURLResponse *response, NSData *data) {
                NSDictionary *dict = JSON_TO_DICT(data);
                NSLog(@"%@", dict);
                int ret = [dict[@"ret"] intValue];
                if (ret == 1) {
                    if ([dict[@"msg"] length] > 0) {
                        [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
                    } else {
                        [SVProgressHUD showErrorWithStatus:@"发生未知错误，修改失败！"];
                    }
                } else if (ret == 0) {
                    [SVProgressHUD dismiss];
                    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"修改成功！"];
                    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
                    [alertView show];
                    // 更新UserDefaults
                    [[SFUserDefaults sharedUserDefaults] setUserInfoWithDictionary:parameters];
                } else {
                    [SVProgressHUD showErrorWithStatus:@"服务器很忙，请重试！"];
                }
            } failed:^(NSURLResponse *response, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"服务器很忙，请重试！"];
            }];
        }
    }
}

@end