//
//  LeftViewHomeBottomCell.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/14.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewHomeBottomCell.h"

@implementation LeftViewHomeBottomCell

- (void)awakeFromNib
{
    // 设置边框
    self.contentView.layer.borderColor = LEFT_VC_TABLE_BORDER_CGCOLOR;
    self.contentView.layer.borderWidth = 0.4f;
    self.backgroundColor = [UIColor clearColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped:)];
    self.titleLabel.userInteractionEnabled = YES;
    [self.titleLabel addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)taped:(UITapGestureRecognizer *)recognizer
{
    [_delegate leftViewHomeBottomCellTaped:self];
}

@end
