//
//  ShoppingCarSelectUserOrderModel.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarSelectUserAllOrderModel.h"
#import "SFUserDefaults.h"

@implementation ShoppingCarSelectUserAllOrderModel

+ (NSString *)APIWithIndex:(int)index {
    int userID = (int)[[SFUserDefaults sharedUserDefaults] requestUserID];
    return [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=SelectOrderList&userid=%d&pageSize=16&index=%d", userID, index];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.createTime =  dictionary[@"create_time"];
        self.orderNumber = dictionary[@"order_number"];
        self.orderID = [dictionary[@"orderid"] intValue];
        self.state = [dictionary[@"state"] unsignedIntegerValue];
        self.totalPrice = [dictionary[@"totalprice"] floatValue];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        NSMutableArray *namesArray = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDict in dictionary[@"orderdetail"]) {
            ShoppingCarSelectUserAllOrderDetailModel *model = [[ShoppingCarSelectUserAllOrderDetailModel alloc] init];
            model.number = [tempDict[@"number"] intValue];
            model.price = [tempDict[@"price"] floatValue];
            model.productName = tempDict[@"productname"];
            [tempArray addObject:tempArray];
            [namesArray addObject:tempDict[@"productname"]];
        }
        self.orderDetail = tempArray;
        self.ordersString = [namesArray componentsJoinedByString:@"、"];
        
        NSString *stateString = nil;
        switch (self.state) {
            case OrderStateAudit:
                stateString = @"审核中";
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
            case OrderStateAuditNotPassed:
                stateString = @"审核失败";
                break;
        }
        self.stateString = stateString;
    }
    return self;
}

@end
