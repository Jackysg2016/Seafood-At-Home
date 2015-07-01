//
//  UserSettingViewModel.h
//  SeafoodHome
//
//  Created by btw on 14/12/26.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UserSettingHeaderViewType)
{
    UserSettingHeaderViewTypeAccountSettings,
    UserSettingHeaderViewTypeOrderManagement,
    UserSettingHeaderViewTypeOutLogin,
//    UserSettingHeaderViewTypeMyWallet,
//    UserSettingHeaderViewTypeLogisticsTracking
};

@interface UserSettingHeaderViewModel : NSObject

@property (assign, nonatomic) BOOL isSelected;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isCanFold;
@property (assign, nonatomic) UserSettingHeaderViewType type;

@end
