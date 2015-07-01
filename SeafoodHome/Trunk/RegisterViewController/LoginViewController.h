//
//  RegisterViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface LoginViewController : UIViewController

- (IBAction)loginButtonClicked:(UIButton *)sender;

- (IBAction)registerButtonClicked:(UIButton *)sender;

- (IBAction)forgetThePasswordButtonClicked:(UIButton *) forgetThePassword;

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (assign, nonatomic) BOOL isFromFirstVC;

- (IBAction)backButtonClicked:(UIButton *)sender;

@end