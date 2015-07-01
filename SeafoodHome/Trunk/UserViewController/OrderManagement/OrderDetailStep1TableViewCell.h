//
//  OrderDetailStep1TableViewCell.h
//  SeafoodHome
//
//  Created by btw on 15/1/20.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCarSelectUserOnceOrderDetailModel;

@interface OrderDetailStep1TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

- (void)updateWithModel:(ShoppingCarSelectUserOnceOrderDetailModel *)model;


+ (CGFloat)height;

@end
