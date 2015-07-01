//
//  ShoppingCarSelectUserOrderModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingCarSelectUserAllOrderDetailModel.h"
#import "SFModelProtocol.h"

/**
 * 订单的状态Enumerator
 */
typedef NS_ENUM(NSUInteger, OrderState){
    /**
     *  审核中
     */
    OrderStateAudit = 0,
    /**
     *  待付款
     */
    OrderStatePending,
    /**
     *  待收货
     */
    OrderStateInbound,
    /**
     *  交易成功
     */
    OrderStateSuccess,
    /**
     *  审核不通过
     */
    OrderStateAuditNotPassed
};

/** 查找某用户的所有订单Model */
@interface ShoppingCarSelectUserAllOrderModel : NSObject <SFModelProtocol>

@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *orderNumber;
@property (strong, nonatomic) NSArray *orderDetail;
@property (assign, nonatomic) int orderID;
@property (assign, nonatomic) float totalPrice;
@property (assign, nonatomic) OrderState state;
@property (strong, nonatomic) NSString *stateString;
/** 订单详情包含的商品的字符串 */
@property (strong, nonatomic) NSString *ordersString;

+ (NSString *)APIWithIndex:(int)index;

@end
