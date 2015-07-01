//
//  LeftViewUserSettingHeaderView.h
//  SeafoodHome
//
//  Created by btw on 14/12/16.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftViewUserSettingHeaderView;

typedef enum
{
    LeftViewUserSettingTypeTable = 0,
    LeftViewUserSettingTypeList
}LeftViewUserSettingHeaderViewType;

@protocol LeftViewUserSettingHeaderViewDelegate <NSObject>

- (void)leftViewUserSettingHeaderView:(LeftViewUserSettingHeaderView *)headerView styleViewTaped:(UIImageView *)styleImageView settingType:(LeftViewUserSettingHeaderViewType)type;

@end

// 高度95
@interface LeftViewUserSettingHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tableStyleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *listStyleImageView;
@property (weak, nonatomic) IBOutlet UILabel *selectedBackgroundView;

@property (assign, nonatomic) id<LeftViewUserSettingHeaderViewDelegate> delegate;

+ (instancetype)leftViewUserSettingHeaderViewWithFrame:(CGRect)frame delegate:(id<LeftViewUserSettingHeaderViewDelegate>)delegate;

- (void)selecteTableStyle;
- (void)selecteListStyle;

@end