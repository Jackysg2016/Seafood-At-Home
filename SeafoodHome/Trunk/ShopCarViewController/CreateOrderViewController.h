//
//  CreateOrderViewController.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/2.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "MainViewController.h"

/**
 *  购物篮步骤2：创建订单的页面视图控制器
 */
@interface CreateOrderViewController : MainViewController

@property (strong, nonatomic) NSArray *dataArray;

/**
 *  初始化创建订单的页面视图控制器
 *
 *  @param dataArray 包含ShoppingCarModel的数组
 *
 *  @return 创建订单的页面视图控制器对象
 */
- (instancetype)initWithDataArray:(NSArray *)dataArray;

@end