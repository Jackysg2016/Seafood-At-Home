//
//  UserChangePasswordViewController.h
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

/**
 *  账户－》账户设置－》用户修改密码视图控制器
 */
@interface UserChangePasswordViewController : MainViewController

@property (strong, nonatomic) IBOutlet UITextField *originallyPasswordTF;

@property (strong, nonatomic) IBOutlet UITextField *newsPasswordTF;

@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTF;

@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;


- (IBAction)confirmButtonClicked:(UIButton *)sender;

@end
