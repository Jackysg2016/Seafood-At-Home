//
//  OrderDetailViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/6.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "MainViewController.h"

/* 订单详情视图控制器 */
@interface OrderDetailViewController : MainViewController

@property (assign, nonatomic) int orderID;

- (instancetype)initWithOrderID:(int)orderID;

@end
