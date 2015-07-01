//
//  OrderDetailStep2TableViewCell.h
//  SeafoodHome
//
//  Created by btw on 15/1/20.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCarSelectUserOnceOrderResolveModel;

@interface OrderDetailStep2TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *realquantityLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;

- (void)updateWithModel:(ShoppingCarSelectUserOnceOrderResolveModel *)model;

+ (CGFloat)height;

@end
