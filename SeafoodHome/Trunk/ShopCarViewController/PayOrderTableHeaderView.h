//
//  PayOrderTableHeaderView.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  订单支付视图控制器的表格头视图
 */
@interface PayOrderTableHeaderView : UITableViewHeaderFooterView

@property (strong, nonatomic) UILabel *titleLabel;

/**
 *  设置表格头视图的标题
 *
 *  @param title 标题
 */
- (void)setTitle:(NSString *)title;

+ (CGFloat)height;

@end
