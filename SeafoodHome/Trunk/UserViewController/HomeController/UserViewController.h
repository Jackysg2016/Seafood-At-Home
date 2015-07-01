//
//  UserViewController.h
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "UserSettingHeaderView.h"
#import "UserSettingTableViewCell.h"
#import "UserSettingHeaderViewModel.h"
#import "UserMyPurseViewController.h"
#import "OrderManagementViewController.h"

#import "UserChangeInfoViewController.h"
#import "UserChangePasswordViewController.h"
#import "UserBindingInfoViewController.h"
#import "UserBookInformationViewController.h"
#import "UserPaymentManagementViewController.h"


/**
 *  主要栏目——账户视图控制器首页
 */
@interface UserViewController : MainViewController
<
    UserSettingTableViewCellDelegate,
    UserSettingHeaderViewDelegate
>

@end
