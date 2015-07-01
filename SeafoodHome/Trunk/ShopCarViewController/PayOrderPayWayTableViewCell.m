//
//  PayOrderPayWayTableViewCell.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "PayOrderPayWayTableViewCell.h"

@implementation PayOrderPayWayTableViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateUIWithImageNamed:(NSString *)imageNamed title:(NSString *)title
{
    _myImageView.image = [UIImage imageNamed:imageNamed];
    _titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {
        [self selecte];
    } else {
        [self unSelecte];
    }
}

- (void)selecte
{
    _singletonButton.selected = YES;
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
}

- (void)unSelecte
{
    _singletonButton.selected = NO;
    self.backgroundColor = [UIColor clearColor];
}

+ (CGFloat)height
{
    return 55.0f;
}

@end
