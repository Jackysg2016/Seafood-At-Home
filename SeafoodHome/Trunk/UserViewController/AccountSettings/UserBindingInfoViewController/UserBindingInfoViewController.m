//
//  UserBindingInfoViewController.m
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "UserBindingInfoViewController.h"
#import "SFConfigurationHandler.h"

@interface UserBindingInfoViewController ()

@end

@implementation UserBindingInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.UIHelper appendingNavTitleWithString:@"绑定电子邮件和手机号码"];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    
    [SFConfigurationHandler setUserSubViewBottomButtonUI:_confirmBtn];
    self.scrollView.contentSize = CGSizeMake(0, 600);
}

- (IBAction)confirmButtonClicked:(id)sender
{
    NSLog(@"confirm button clicked");
}

@end
