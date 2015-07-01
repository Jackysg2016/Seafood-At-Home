//
//  LeftViewUserSettingCell.m
//  SeafoodHome
//
//  Created by btw on 14/12/16.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewUserSettingCell.h"

@implementation LeftViewUserSettingCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    self.contentView.layer.borderColor = LEFT_VC_TABLE_BORDER_CGCOLOR;
    self.contentView.layer.borderWidth = 0.3f;
}

- (void)updateUIWithTitle:(NSString *)title highlight:(BOOL)isHighlight delegate:(id<LeftViewUserSettingCellDelegate>)delegate
{
    self.settingLabel.text = title;
    self.settingStatusImageView.highlighted = isHighlight;
    self.delegate = delegate;
    
    self.settingStatusImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(statusImageViewTaped:)];
    [self.settingStatusImageView addGestureRecognizer:tap];
}

- (void)statusImageViewTaped:(UITapGestureRecognizer *)recognizer
{
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    if(imageView.highlighted)
    {
        [_delegate leftViewUserSettingCell:self deselectedTitle:self.settingLabel.text];
        imageView.highlighted = NO;
    }
    else
    {
        [_delegate leftViewUserSettingCell:self selectedTitle:self.settingLabel.text];
        imageView.highlighted = YES;
    }
}

@end
