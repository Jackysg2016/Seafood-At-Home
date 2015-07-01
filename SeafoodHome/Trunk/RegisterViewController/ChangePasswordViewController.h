//
//  ChangePasswordViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@property (weak, nonatomic) IBOutlet UITextField *newsPasswordTF;

@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;

- (IBAction)confirmBtnClicked:(UIButton *)sender;

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber authCode:(NSString *)authCode IPAddress:(NSString *)IPAddress;

@end
