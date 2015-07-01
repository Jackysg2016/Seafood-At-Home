//
//  UserSettingHeaderView.h
//  SeafoodHome
//
//  Created by btw on 14/12/23.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSettingHeaderViewModel.h"



@class UserSettingHeaderView;

@protocol  UserSettingHeaderViewDelegate <NSObject>

- (void)userSettingHeaderViewClicked:(UserSettingHeaderView *)headerView titleText:(NSString *)titleText;

@end

@interface UserSettingHeaderView : UITableViewHeaderFooterView
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (strong, nonatomic) IBOutlet UIView *bgView;

/**
 *  delegate
 */
@property (weak, nonatomic) id<UserSettingHeaderViewDelegate> delegate;

@property (strong, nonatomic) UserSettingHeaderViewModel *model;

- (void)updateUIWithModel:(UserSettingHeaderViewModel *)model delegate:(id<UserSettingHeaderViewDelegate>)delegate;

@end
