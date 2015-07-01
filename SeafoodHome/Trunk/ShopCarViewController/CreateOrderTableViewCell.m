//
//  CreateOrderTableViewCell.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "CreateOrderTableViewCell.h"
#import "ShoppingCarModel.h"
#import "Masonry.h"

@implementation CreateOrderTableViewCell

- (void)awakeFromNib
{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsZero;
    self.backgroundColor = [UIColor clearColor];
}

- (void)updateUIWithModel:(ShoppingCarModel *)model {
    _titleLabel.text = model.title;
    _amountLabel.text = [NSString stringWithFormat:@"数量：%d", model.amount];
    _priceLabel.text = [NSString stringWithFormat:@"单价：%@", PRICE_STR(model.unitPrice)];
    _sizeLabel.text = [NSString stringWithFormat:@"规格：%@", model.specification];
}

+ (CGFloat)height
{
    return 66.0f;
}

@end
