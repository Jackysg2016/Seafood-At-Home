//
//  PositionIconView.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/7.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "PositionIconView.h"

@implementation PositionIconView

+ (instancetype)positionIconViewWithFrame:(CGRect)frame imageNamed:(NSString *)imageNamed labelText:(NSString *)text delegate:(id<PositionIconViewDelegate>)delegate
{
    PositionIconView *positionIconView = SELF_NIB;
    positionIconView.frame = frame;
    positionIconView.myImageView.image = [UIImage imageNamed:imageNamed];
    positionIconView.myLabel.text = text;
    positionIconView.delegate = delegate;
    return positionIconView;
}

- (void)setDelegate:(id<PositionIconViewDelegate>)delegate
{
    _delegate = delegate;
    
    // item
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(positionViewTap:)];
    [self addGestureRecognizer:tapRecognizer];
}

- (void)positionViewTap:(UITapGestureRecognizer *)recognizer
{
    if (_delegate)
    {
        [_delegate positionIconViewClicked:self];
    }
}

@end
