//
//  LeftViewPositionButtonView.m
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewPositionButtonView.h"

@implementation LeftViewPositionButtonView

+ (instancetype)leftViewPositionButtonViewWithFrame:(CGRect)frame iconImageSize:(CGSize)iconImageSize iconImageNamed:(NSString *)imageNamed highlightedImageNamed:(NSString *)highlightedImageNamed
{
    LeftViewPositionButtonView *view = SELF_NIB;
    view.frame = frame;
    view.iconImageView.frame = CGRectMake(0, 0, iconImageSize.width, iconImageSize.height);
    view.iconImageView.center = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
    view.iconImageView.image = [UIImage imageNamed:imageNamed];
    if (![highlightedImageNamed isEqual:[NSNull null]])
    {
        view.iconImageView.highlightedImage = [UIImage imageNamed:highlightedImageNamed];
    }
    
    // 设置边框
    view.layer.borderColor = LEFT_VC_TABLE_BORDER_CGCOLOR;
    view.layer.borderWidth = 0.3f;
    return view;
}

@end
