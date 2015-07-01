//
//  UserBookInformationViewController.m
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "UserBookInformationViewController.h"

@interface UserBookInformationViewController ()

@end

@implementation UserBookInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    [self.UIHelper appendingNavTitleWithString:@"预定信息"];
}

@end
