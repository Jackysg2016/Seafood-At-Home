//
//  OrderPayTableViewCell.h
//  SeafoodHome
//
//  Created by btw on 15/1/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  订单支付视图控制器的表格单元
 */
@interface PayOrderTableViewCell : UITableViewCell

/**
 *  标题Label
 */
@property (strong, nonatomic) UILabel *titleLabel;

/**
 *  描述Label
 */
@property (strong, nonatomic) UILabel *descLabel;

/**
 *  更新UI用标题和描述
 *
 *  @param title 标题
 *  @param desc  描述
 */
- (void)updateUIWithTitle:(NSString *)title desc:(NSString *)desc;

/**
 *  订单支付视图控制器的表格单元视图的高度
 *
 *  @return 高度值
 */
+ (CGFloat)height;


@end
