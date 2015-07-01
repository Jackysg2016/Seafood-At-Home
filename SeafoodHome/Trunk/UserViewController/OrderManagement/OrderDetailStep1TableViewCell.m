//
//  OrderDetailStep1TableViewCell.m
//  SeafoodHome
//
//  Created by btw on 15/1/20.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "OrderDetailStep1TableViewCell.h"
#import "ShoppingCarSelectUserOnceOrderDetailModel.h"

@implementation OrderDetailStep1TableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)updateWithModel:(ShoppingCarSelectUserOnceOrderDetailModel *)model {
    self.titleLabel.text = model.productName;
    self.sizeLabel.text = model.specificationString;
    self.numberLabel.text = model.numberString;
    self.priceLabel.text = model.priceString;
}

+ (CGFloat)height {
    return 66.0;
}

@end
