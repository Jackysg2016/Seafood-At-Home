//
//  UserSettingTableViewCell.h
//  SeafoodHome
//
//  Created by btw on 14/12/23.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UserSettingTableViewCellButtonType)
{
    UserSettingTableViewCellButtonTypeChangeSelfInfo = 0,
    UserSettingTableViewCellButtonTypeChangePassword,
    UserSettingTableViewCellButtonTypeBoundMailOrPhone,
    UserSettingTableViewCellButtonTypeReadyInfoSetting,
    UserSettingTableViewCellButtonTypePayManage
};

@class UserSettingTableViewCell;

@protocol UserSettingTableViewCellDelegate <NSObject>

- (void)userSettingTableViewCell:(UserSettingTableViewCell *)cell clickedType:(UserSettingTableViewCellButtonType)type;

@end

@interface UserSettingTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *changeSelfInfo;
@property (strong, nonatomic) IBOutlet UILabel *changePassword;
@property (strong, nonatomic) IBOutlet UILabel *boundMailOrPhone;
@property (strong, nonatomic) IBOutlet UIButton *readyInfoSetting;
@property (strong, nonatomic) IBOutlet UIButton *payManage;

@property (weak, nonatomic) id<UserSettingTableViewCellDelegate> delegate;

@end
