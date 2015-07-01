//
//  UserMyPurseViewController.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/26.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "UILabel+FormattedText.h"

/**
 *  UserMyPurseViewController按钮的类型
 */
typedef NS_ENUM(NSUInteger, UserMyPurseViewButtonType)
{
    /**
     *  预付款
     */
    UserMyPurseViewButtonTypePrepayments = 10,
    /**
     *  转账
     */
    UserMyPurseViewButtonTypeTransfers,
    /**
     *  提现
     */
    UserMyPurseViewButtonTypeWithdrawals,
    /**
     *  代付
     */
    UserMyPurseViewButtonTypePayForAnother,
    /**
     *  马上去
     */
    UserMyPurseViewButtonTypeLetsGo
};

/** 我的钱包视图控制器 */
@interface UserMyPurseViewController : MainViewController

@property (strong, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (strong, nonatomic) IBOutlet UILabel *helloLabel;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;

/**
 *  按钮点击事件
 *
 *  @param button 触发的按钮
 */
- (IBAction)buttonsClicked:(UIButton *)button;

@end
