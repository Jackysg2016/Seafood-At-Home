//
//  UserChangeInfoViewController.h
//  SeafoodHome
//
//  Created by btw on 14/12/26.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

/** 修改个人信息 */
@interface UserChangeInfoViewController : MainViewController

@property (strong, nonatomic) IBOutlet UITextField *changeUserNameTF;
@property (strong, nonatomic) IBOutlet UITextField *changePhoneNumberTF;
@property (strong, nonatomic) IBOutlet UITextField *changeMailTF;
@property (strong, nonatomic) IBOutlet UITextField *changeAddressTF;

@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;

@end
