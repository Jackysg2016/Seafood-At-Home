//
//  DefaultTarBarItemView.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/8.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DefaultTabBarItemView.h"

@implementation DefaultTabBarItemView

+ (instancetype)defaultTabBarItemViewWithFrame:(CGRect)frame imageNamed:(NSString *)imageNamed title:(NSString *)title
{
    DefaultTabBarItemView *defaultTabBarItemView = SELF_NIB;
    defaultTabBarItemView.frame = frame;
    
    // 设置图片
    defaultTabBarItemView.myImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal", imageNamed]];
    defaultTabBarItemView.myImageView.highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_light", imageNamed]];
    
    defaultTabBarItemView.myLabel.text = title;
    return defaultTabBarItemView;
}

- (void)setSelectedState
{
    self.myImageView.highlighted = YES;
    self.myLabel.highlighted = YES;
    self.selectedBackgroundView.hidden = NO;
}

- (void)setDeselectedState
{
    self.myImageView.highlighted = NO;
    self.myLabel.highlighted = NO;
    self.selectedBackgroundView.hidden = YES;
}

@end
