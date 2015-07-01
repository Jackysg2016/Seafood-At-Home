//
//  ShoppingCarSelectUserAllOrderDetailModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/20.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 查找所有用户的订单的订单详情Model */
@interface ShoppingCarSelectUserAllOrderDetailModel : NSObject

@property (assign, nonatomic) int number;
@property (assign, nonatomic) float price;
@property (strong, nonatomic) NSString *productName;

@end
