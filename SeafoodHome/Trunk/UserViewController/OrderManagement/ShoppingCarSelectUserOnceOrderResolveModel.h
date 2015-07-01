//
//  ShoppingCarSelectUserOnceOrderResolveModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/20.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFModelProtocol.h"

/** 获取某个订单的已经审评（Resolve）的Model */
@interface ShoppingCarSelectUserOnceOrderResolveModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) int productID;
@property (strong, nonatomic) NSString *productName;
@property (assign, nonatomic) float originalPrice;
@property (assign, nonatomic) float realPrice;
@property (assign, nonatomic) float realquantity;
/** 是否没有签收，1是拒收，0是已经收了 */
@property (assign ,nonatomic) BOOL isFailAccept;
@property (strong, nonatomic) NSString *specification;
@property (strong, nonatomic) NSString *unit;

// extension
@property (strong, nonatomic) NSString *specificationString;
@property (strong, nonatomic) NSString *realPriceString;
@property (strong, nonatomic) NSString *realquantityString;

@end
