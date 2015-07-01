//
//  ShoppingCarSelectUserOnceOrderModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/15.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingCarSelectUserAllOrderModel.h"
#import "ShoppingCarSelectUserOnceOrderDetailModel.h"
#import "ShoppingCarSelectUserOnceOrderResolveModel.h"
#import "SFModelProtocol.h"

/**
 *  订单的支付方式
 */
typedef NS_ENUM(NSUInteger, OrderPayType){
    /**
     *  未付款
     */
    OrderPayTypeNonPayment = 0,
    /**
     *  PC银联
     */
    OrderPayTypePCUnion,
    /**
     *  手机银联
     */
    OrderPayTypeMobileUnion,
    /**
     *  货到付款
     */
    OrderPayTypeCOD
};

/** 获取某个订单Model */
@interface ShoppingCarSelectUserOnceOrderModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) int orderID;
@property (assign, nonatomic) float totalPrice;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *orderNumber;
@property (strong, nonatomic) NSString *createTitme;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *realName;
/**
 *  ShoppingCarSelectUserOnceOrderDetailModel
 */
@property (strong, nonatomic) NSArray *detailArray;
/**
 *  ShoppingCarSelectUserOnceOrderResolveModel
 */
@property (strong, nonatomic) NSArray *resolveArray;
@property (assign, nonatomic) OrderPayType payType;
@property (assign, nonatomic) OrderState state;

// Extension
@property (strong, nonatomic) NSString *totalPriceString;
@property (strong, nonatomic) NSString *payTypeString;
@property (strong, nonatomic) NSString *stateString;

+ (NSString *)APIWithOrderID:(int)orderID;

@end
