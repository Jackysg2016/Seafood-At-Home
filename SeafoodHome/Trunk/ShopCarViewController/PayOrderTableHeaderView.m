//
//  PayOrderTableHeaderView.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "PayOrderTableHeaderView.h"

@implementation PayOrderTableHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _titleLabel.layer.borderWidth = 0.25f;
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = MyFont(18.0);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = [@"   " stringByAppendingString:title];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleLabel.frame = self.contentView.bounds;
}

+ (CGFloat)height
{
    return 45;
}

@end
