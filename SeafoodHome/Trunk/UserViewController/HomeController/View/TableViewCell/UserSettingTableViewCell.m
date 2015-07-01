//
//  UserSettingTableViewCell.m
//  SeafoodHome
//
//  Created by btw on 14/12/23.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "UserSettingTableViewCell.h"

@implementation UserSettingTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    [_changeSelfInfo addTarget:self action:@selector(changeSelfInfoClicked) forControlEvents:UIControlEventTouchUpInside];
    [_readyInfoSetting addTarget:self action:@selector(readyInfoSettingClicked) forControlEvents:UIControlEventTouchUpInside];
    [_payManage addTarget:self action:@selector(payManageClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addGestureRecognizerWithObject:_changePassword selector:@selector(changePasswordClicked)];
    [self addGestureRecognizerWithObject:_boundMailOrPhone selector:@selector(boundMainOrPhoneClicked)];
}

#pragma mark- Control Methods

- (void)changeSelfInfoClicked
{
    [_delegate userSettingTableViewCell:self clickedType:UserSettingTableViewCellButtonTypeChangeSelfInfo];
}

- (void)readyInfoSettingClicked
{
    [_delegate userSettingTableViewCell:self clickedType:UserSettingTableViewCellButtonTypeReadyInfoSetting];
}

- (void)payManageClicked
{
    [_delegate userSettingTableViewCell:self clickedType:UserSettingTableViewCellButtonTypePayManage];
}

- (void)changePasswordClicked
{
    [_delegate userSettingTableViewCell:self clickedType:UserSettingTableViewCellButtonTypeChangePassword];
}

- (void)boundMainOrPhoneClicked
{
    [_delegate userSettingTableViewCell:self clickedType:UserSettingTableViewCellButtonTypeBoundMailOrPhone];
}

#pragma mark- AddGestureRecognizerWithObject

- (void)addGestureRecognizerWithObject:(id)object selector:(SEL)selector
{
    [object setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [object addGestureRecognizer:tap];
}

@end
