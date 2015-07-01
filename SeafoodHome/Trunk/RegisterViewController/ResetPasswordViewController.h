//
//  ResetPasswordViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController

/**
 *  手机号码TextField
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;

/**
 *  验证码TextField
 */
@property (weak, nonatomic) IBOutlet UITextField *authCodeTF;

/**
 *  获取验证码按钮点击事件
 *
 *  @param sender 按钮
 */
- (IBAction)authCodeButtonClicked:(UIButton *)sender;

/**
 *  确认按钮点击事件
 *
 *  @param sender 确认按钮
 */
- (IBAction)confirmButtonClicked:(UIButton *)sender;

/**
 *  返回按钮点击事件
 *
 *  @param sender 返回按钮
 */
- (IBAction)backButtonClicked:(UIButton *)sender;

@end