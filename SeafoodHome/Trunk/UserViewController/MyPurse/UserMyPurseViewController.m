//
//  UserMyPurseViewController.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/26.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "UserMyPurseViewController.h"

@interface UserMyPurseViewController ()

@end

@implementation UserMyPurseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.UIHelper appendingNavTitleWithString:@"电子钱包"];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];

    self.automaticallyAdjustsScrollViewInsets = NO;
    _bgScrollView.frame  = ROOT_VIEW_FRAME2;
    _bgScrollView.contentSize = CGSizeMake(VIEW_SIZE.width, 555);
    [_balanceLabel setFont:MyFont(24.0f) range:NSMakeRange(0, 1)];
    [self changeButtonsLayer];
}

- (void)changeButtonsLayer
{
    // buttons tag is between 10 and 14
    for (int i = 10; i<=14; i++)
    {
        UIButton *button = (UIButton *)[_bgScrollView viewWithTag:i];
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = RGB(139, 137, 131).CGColor;
        button.layer.cornerRadius = 5.0f;
        button.layer.masksToBounds = YES;
    }
}

- (IBAction)buttonsClicked:(UIButton *)button
{
    NSUInteger tag = button.tag;
    
    if (UserMyPurseViewButtonTypePrepayments == tag)
    {
        NSLog(@"UserMyPurseViewButtonTypePrepayments");
    }
    else if (UserMyPurseViewButtonTypeTransfers == tag)
    {
        NSLog(@"UserMyPurseViewButtonTypeTransfers");
    }
    else if (UserMyPurseViewButtonTypeWithdrawals == tag)
    {
        NSLog(@"UserMyPurseViewButtonTypeWithdrawals");
    }
    else if (UserMyPurseViewButtonTypePayForAnother == tag)
    {
        NSLog(@"UserMyPurseViewButtonTypePayForAnother");
    }
    else if (UserMyPurseViewButtonTypeLetsGo == tag)
    {
        NSLog(@"UserMyPurseViewButtonTypeLetsGo");
    }
}

@end
