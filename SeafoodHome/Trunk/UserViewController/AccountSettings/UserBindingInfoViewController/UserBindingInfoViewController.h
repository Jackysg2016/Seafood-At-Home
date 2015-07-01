//
//  UserBindingInfoViewController.h
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

/**
 *  账户－》账户设置－》绑定电子邮件和手机号码视图控制器
 */
@interface UserBindingInfoViewController : MainViewController

@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;

- (IBAction)confirmButtonClicked:(id)sender;

@end
