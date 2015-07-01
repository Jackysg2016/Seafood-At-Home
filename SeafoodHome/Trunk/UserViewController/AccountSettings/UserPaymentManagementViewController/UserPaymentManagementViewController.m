//
//  UserPaymentManagementViewController.m
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "UserPaymentManagementViewController.h"

@interface UserPaymentManagementViewController ()

@end

@implementation UserPaymentManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.UIHelper appendingNavTitleWithString:@"支付管理"];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
}

@end
