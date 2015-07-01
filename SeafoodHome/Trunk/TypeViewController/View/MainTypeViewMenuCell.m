//
//  MainTypeViewMenuCell.m
//  SeafoodHome
//
//  Created by btw on 14/12/17.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainTypeViewMenuCell.h"

@implementation MainTypeViewMenuCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.myArrowImageView.hidden = YES;
}

- (void)updateCellWithTitle:(NSString *)title
{
    self.myTitleLabel.text = title;
}

- (void)selectedStatus
{
    self.selected = YES;
    self.backgroundColor = MAIN_YELLOW_COLOR;
    self.myTitleLabel.textColor = [UIColor whiteColor];
    self.myArrowImageView.hidden = NO;
}

- (void)unSelectedStatus
{
    self.selected = NO;
    self.backgroundColor = [UIColor clearColor];
    self.myTitleLabel.textColor = [UIColor darkGrayColor];
    self.myArrowImageView.hidden = YES;
}

@end
