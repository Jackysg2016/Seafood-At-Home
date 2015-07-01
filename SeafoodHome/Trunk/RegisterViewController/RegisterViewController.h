//
//  RegisterViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;

@property (weak, nonatomic) IBOutlet UITextField *authCodeTF;

@property (weak, nonatomic) IBOutlet UITextField *password1TF;

@property (weak, nonatomic) IBOutlet UITextField *password2TF;

- (IBAction)authCodeBtnClicked:(UIButton *)sender;

- (IBAction)confirmButtonClicked:(id)sender;

- (IBAction)backButtonClicked:(id)sender;

@end
