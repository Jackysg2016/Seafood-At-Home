//
//  LeftViewUserSettingHeaderView.m
//  SeafoodHome
//
//  Created by btw on 14/12/16.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewUserSettingHeaderView.h"
#import "SFUserDefaults.h"

@implementation LeftViewUserSettingHeaderView

+ (instancetype)leftViewUserSettingHeaderViewWithFrame:(CGRect)frame delegate:(id<LeftViewUserSettingHeaderViewDelegate>)delegate
{
    LeftViewUserSettingHeaderView *headerView = SELF_NIB;
    headerView.frame = frame;
    headerView.selectedBackgroundView.hidden = YES;
    headerView.delegate = delegate;
    
    if ([[SFUserDefaults sharedUserDefaults] productListCollectionViewStyle] == ProductListCollectionViewStyleGrid)
    {
        [headerView selecteTableStyle];
    }
    else
    {
        [headerView selecteListStyle];
    }
    return headerView;
}

- (void)awakeFromNib
{
    _selectedBackgroundView.layer.cornerRadius = 3.0f;
    _selectedBackgroundView.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    NSArray *arr = @[self.tableStyleImageView, self.listStyleImageView];
    for (int i = 0; i<arr.count; i++)
    {
        [arr[i] setTag:i];
        [arr[i] setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(styleViewTaped:)];
        [arr[i] addGestureRecognizer:tap];
    }
}

- (void)styleViewTaped:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.view.tag == LeftViewUserSettingTypeTable)
    {
        [self selecteTableStyle];
    }
    else if(recognizer.view.tag == LeftViewUserSettingTypeList)
    {
        [self selecteListStyle];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(leftViewUserSettingHeaderView:styleViewTaped:settingType:)])
    {
        [_delegate leftViewUserSettingHeaderView:self styleViewTaped:(UIImageView *)recognizer.view settingType:(int)recognizer.view.tag];
    }
    
    
}

- (void)selecteTableStyle
{
    [self selecteTargetWithImageView:_tableStyleImageView];
}

- (void)selecteListStyle
{
    [self selecteTargetWithImageView:_listStyleImageView];
}

- (void)selecteTargetWithImageView:(UIImageView *)imageView
{
    _selectedBackgroundView.hidden  = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        _selectedBackgroundView.center = imageView.center;
    }];
}

@end
