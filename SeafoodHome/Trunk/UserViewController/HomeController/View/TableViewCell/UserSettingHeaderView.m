//
//  UserSettingHeaderView.m
//  SeafoodHome
//
//  Created by btw on 14/12/23.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "UserSettingHeaderView.h"

static NSString * const kBackgroundImageNamed = @"main_bg";

@interface UserSettingHeaderView()

@end

@implementation UserSettingHeaderView

- (void)updateUIWithModel:(UserSettingHeaderViewModel *)model delegate:(id<UserSettingHeaderViewDelegate>)delegate
{
    _model = model;
    _titleLabel.text = _model.title;
    _delegate = delegate;
    
    if (_model.isCanFold)
    {
//        _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    
    if (_model.isCanFold && _model.isSelected)
    {
        _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, -M_PI/2);
    }
}

- (void)awakeFromNib
{
    _bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundImageNamed]];
    
    _titleLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    [_titleLabel addGestureRecognizer:tap];
}

- (void)clicked:(UITapGestureRecognizer *)recognizer
{
    _model.isSelected = !_model.isSelected;
    
    if (_model.isCanFold) {
        [self arrowExecuteAnimation];
    }
    
    // send click event to delegate
    [_delegate userSettingHeaderViewClicked:self titleText:_model.title];
}

- (void)arrowExecuteAnimation {
    if (_model.isSelected) {
        [UIView animateWithDuration:0.5 animations:^{
//            _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, M_PI/2);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
//            _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, -M_PI/2);
        }];
    }
}

@end
