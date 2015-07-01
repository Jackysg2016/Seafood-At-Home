//
//  LeftViewUserSettingCell.h
//  SeafoodHome
//
//  Created by btw on 14/12/16.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftViewUserSettingCell;

@protocol LeftViewUserSettingCellDelegate <NSObject>

- (void)leftViewUserSettingCell:(LeftViewUserSettingCell *)cell selectedTitle:(NSString *)selectedTitle;

- (void)leftViewUserSettingCell:(LeftViewUserSettingCell *)cell deselectedTitle:(NSString *)deselectedTitle;

@end

@interface LeftViewUserSettingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *settingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *settingStatusImageView;

@property (assign, nonatomic) id<LeftViewUserSettingCellDelegate> delegate;

/**
 *  用于配置UI
 *
 *  @param title       左边的title text
 *  @param isHighlight 是否已经选中
 *  @param delegate    需要设置的代理
 */
- (void)updateUIWithTitle:(NSString *)title highlight:(BOOL)isHighlight delegate:(id<LeftViewUserSettingCellDelegate>)delegate;

@end
