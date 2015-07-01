//
//  LeftViewHomeStrongColumnCell.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/14.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewHomeStrongColumnCell.h"

@implementation LeftViewHomeStrongColumnCell

- (void)createUIWithDelegate:(id<LeftViewHomeStrongColumnCellDelegate>)delegate
{
    if (_delegate)
    {
        return;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.frame = CGRectMake(0, 0, AUTO_MATE_WIDTH(320-55), AUTO_MATE_WIDTH(90));
    self.backgroundColor = [UIColor clearColor];
    
    NSArray *titles = @[@"购物篮", @"我的账号", @"用户设置"];
    NSArray *icons = @[@"left_view_home_shopcar", @"left_view_home_user", @"left_view_home_setting"];
    
    float buttonViewWidth = self.contentView.frame.size.width/3.0;
    
    for (int i = 0; i < 3; i++)
    {
        LeftViewMiddleButtonView *buttonView = [LeftViewMiddleButtonView leftViewMiddleButtonViewWithFrame:CGRectMake(buttonViewWidth*i, 0, buttonViewWidth, self.contentView.frame.size.height) iconImageNamed:icons[i] title:titles[i]];
        buttonView.tag = i;
        [self.contentView addSubview:buttonView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonViewTaped:)];
        [buttonView addGestureRecognizer:tap];
    }
    
    _delegate = delegate;

}

- (void)buttonViewTaped:(UITapGestureRecognizer *)recognizer
{
    switch (recognizer.view.tag)
    {
        case 0:
            [_delegate leftViewHomeStrongColumnCell:self buttonViewTapType:StrongColumnTypeShoppingCar];
            break;
        case 1:
            [_delegate leftViewHomeStrongColumnCell:self buttonViewTapType:StrongColumnTypeMyAccount];
            break;
        case 2:
            [_delegate leftViewHomeStrongColumnCell:self buttonViewTapType:StrongColumnTypeUserSetting];
            break;
    }
}


@end
