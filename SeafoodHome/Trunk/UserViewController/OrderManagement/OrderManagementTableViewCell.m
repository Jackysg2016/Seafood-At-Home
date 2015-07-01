//
//  OrderManagementTableViewCell.m
//  SeafoodHome
//
//  Created by btw on 15/1/6.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "OrderManagementTableViewCell.h"
#import "ShoppingCarSelectUserAllOrderModel.h"

@implementation OrderManagementTableViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateWithModel:(ShoppingCarSelectUserAllOrderModel *)model {
    _orderNumberLabel.text = [NSString stringWithFormat:@"订单编号：%@", model.orderNumber];
    _statusLabel.text = model.stateString;
    _titleLabel.text = model.ordersString;
    if (model.totalPrice == 0 || model.state == OrderStateAudit || model.state == OrderStateAuditNotPassed) {
        _priceLabel.hidden = YES;
    } else {
        _priceLabel.hidden = NO;
        _priceLabel.text = PRICE_STR(model.totalPrice);
    }
    
    if (model.state == OrderStateSuccess) {
        _statusLabel.textColor = RGB(87, 160, 0);
    } else if (model.state == OrderStatePending) {
        _statusLabel.textColor = RGB(181, 48, 40);
    } else {
        _statusLabel.textColor = [UIColor grayColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

+ (CGFloat)height
{
    return 64.0f;
}

@end
