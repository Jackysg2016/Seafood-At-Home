//
//  OrderPayTableViewCell.m
//  SeafoodHome
//
//  Created by btw on 15/1/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "PayOrderTableViewCell.h"
#import "Masonry.h"

@implementation PayOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentRight;
    _titleLabel.font = MyFont(14.0f);
    _titleLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_titleLabel];
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.textAlignment = NSTextAlignmentLeft;
    _descLabel.font = MyFont(14.0f);
    _descLabel.textColor = [UIColor darkGrayColor];
    _descLabel.numberOfLines = 0;
    [self.contentView addSubview:_descLabel];
    
    // config layout
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.height.greaterThanOrEqualTo(@23);
        make.bottom.equalTo(@0);
        make.left.equalTo(@4);
        make.width.equalTo(@80);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(3);
        make.top.equalTo(_titleLabel.mas_top);
        make.right.equalTo(@(-8));
        make.bottom.equalTo(_titleLabel.mas_bottom);
    }];
}


- (void)updateUIWithTitle:(NSString *)title desc:(NSString *)desc
{
    _titleLabel.text = title;
    _descLabel.text = desc;
    
    if ([desc hasPrefix:@"￥"]) {
        _descLabel.textColor = RGB(181, 48, 40);
    } else {
        _descLabel.textColor = [UIColor darkGrayColor];
    }
}

+ (CGFloat)height
{
    return 50;
}

@end
