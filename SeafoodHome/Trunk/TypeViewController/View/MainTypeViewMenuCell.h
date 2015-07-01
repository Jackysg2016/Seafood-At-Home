//
//  MainTypeViewMenuCell.h
//  SeafoodHome
//
//  Created by btw on 14/12/17.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTypeViewMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myArrowImageView;

/**
 *  更新UI
 *
 *  @param title  标题
 */
- (void)updateCellWithTitle:(NSString *)title;

/** 设置选中的状态 */
- (void)selectedStatus;

/** 设置未选中的状态 */
- (void)unSelectedStatus;

@end
