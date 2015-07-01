//
//  ShoppingCarSelectUserOnceOrderDetailModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/20.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFModelProtocol.h"

/** 获取某个订单的订单详情Model */
@interface ShoppingCarSelectUserOnceOrderDetailModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) float price;
@property (assign, nonatomic) int number;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSString *specification;
@property (strong, nonatomic) NSString *productName;

// extension
@property (strong, nonatomic) NSString *specificationString;
@property (strong, nonatomic) NSString *numberString;
@property (strong, nonatomic) NSString *priceString;

@end
