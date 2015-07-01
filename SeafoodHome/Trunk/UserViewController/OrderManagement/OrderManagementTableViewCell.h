//
//  OrderManagementTableViewCell.h
//  SeafoodHome
//
//  Created by btw on 15/1/6.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCarSelectUserAllOrderModel;

@interface OrderManagementTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void)updateWithModel:(ShoppingCarSelectUserAllOrderModel *)model;

+ (CGFloat)height;

@end
