//
//  OrderDetailStep2TableViewCell.m
//  SeafoodHome
//
//  Created by btw on 15/1/20.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "OrderDetailStep2TableViewCell.h"
#import "ShoppingCarSelectUserOnceOrderResolveModel.h"

@implementation OrderDetailStep2TableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)updateWithModel:(ShoppingCarSelectUserOnceOrderResolveModel *)model {
    self.titleLabel.text = model.productName;
    self.sizeLabel.text = model.specificationString;
    self.realquantityLabel.text = model.realquantityString;
    self.totalPriceLabel.text = model.realPriceString;
}

+ (CGFloat)height {
    return 66.0;
}

@end
