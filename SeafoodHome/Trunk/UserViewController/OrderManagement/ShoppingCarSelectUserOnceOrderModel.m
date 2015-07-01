//
//  ShoppingCarSelectUserOnceOrderModel.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/15.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarSelectUserOnceOrderModel.h"

@implementation ShoppingCarSelectUserOnceOrderModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.address = dictionary[@"address"];
        self.createTitme = dictionary[@"create_time"];
        self.message = dictionary[@"message"];
        self.orderNumber = dictionary[@"order_number"];
        
        if ([dictionary[@"orderdetail"] isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (NSDictionary *tempDict in dictionary[@"orderdetail"]) {
                ShoppingCarSelectUserOnceOrderDetailModel *model = [[ShoppingCarSelectUserOnceOrderDetailModel alloc] initWithDictionary:tempDict];
                [tempArray addObject:model];
            }
            self.detailArray = tempArray;
        }
        
        self.orderID = [dictionary[@"orderid"] intValue];
        self.payType = [dictionary[@"paytype"] unsignedIntegerValue];
        self.phoneNumber = dictionary[@"phone"];
        self.realName = dictionary[@"realname"];
        
        if ([dictionary[@"resolve"] isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (NSDictionary *tempDict in dictionary[@"resolve"]) {
                ShoppingCarSelectUserOnceOrderResolveModel *model = [[ShoppingCarSelectUserOnceOrderResolveModel alloc] initWithDictionary:tempDict];
                [tempArray addObject:model];
            }
            self.resolveArray = tempArray;
        }
        
        self.state = [dictionary[@"state"] unsignedIntegerValue];
        self.totalPrice = [dictionary[@"totalprice"] floatValue];
        
        // Extension
        NSString *payTypeString = nil;
        switch (self.payType) {
            case OrderPayTypeMobileUnion:
                payTypeString = @"手机银联";
                break;
            case OrderPayTypeCOD:
                payTypeString = @"货到付款";
                break;
            case OrderPayTypeNonPayment:
                payTypeString = @"未付款";
                break;
            case OrderPayTypePCUnion:
                payTypeString = @"PC银联";
                break;
        }
        self.payTypeString = payTypeString;
        
        NSString *stateString = nil;
        switch (self.state) {
            case OrderStateAudit:
                stateString = @"审核中";
                break;
            case OrderStateAuditNotPassed:
                stateString = @"审核不通过";
                break;
            case OrderStateInbound:
                stateString = @"待收货";
                break;
            case OrderStatePending:
                stateString = @"待付款";
                break;
            case OrderStateSuccess:
                stateString = @"交易成功";
                break;
        }
        self.stateString = stateString;
        
        self.totalPriceString = PRICE_STR(self.totalPrice);
        
        // 条件
        if (self.message == nil || [self.message isEqualToString:@""]) {
            self.message = @"无";
        }
    }
    return self;
}

+ (NSString *)APIWithOrderID:(int)orderID {
    return [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=SelectOrder&orderid=%d", orderID];
}

@end
