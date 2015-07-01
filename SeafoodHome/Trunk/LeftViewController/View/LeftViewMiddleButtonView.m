//
//  LeftViewMiddleButtonView.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/14.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewMiddleButtonView.h"

@implementation LeftViewMiddleButtonView

+ (instancetype)leftViewMiddleButtonViewWithFrame:(CGRect)frame iconImageNamed:(NSString *)imageNamed title:(NSString *)title
{
    LeftViewMiddleButtonView *view = SELF_NIB;
    view.frame = frame;
    view.iconImageView.image = [UIImage imageNamed:imageNamed];
    view.titleLabel.text = title;
    
    // 设置边框
    view.layer.borderColor = LEFT_VC_TABLE_BORDER_CGCOLOR;
    view.layer.borderWidth = 0.3f;
    return view;
}

@end
