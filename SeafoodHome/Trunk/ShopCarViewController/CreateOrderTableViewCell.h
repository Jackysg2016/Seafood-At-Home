//
//  CreateOrderTableViewCell.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCarModel;

/**
 *  创建订单表格单元
 */
@interface CreateOrderTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) ShoppingCarModel *model;

- (void)updateUIWithModel:(ShoppingCarModel *)model;

+ (CGFloat)height;

@end
