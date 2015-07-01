//
//  ShoppingCarChangeOrderModel.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarChangeOrderModel.h"

@implementation ShoppingCarChangeOrderModel

- (NSDictionary *)postDictionary {
    return @{
             @"orderid" : @(self.orderID),
             @"realname" : self.realName,
             @"phone" : self.phone,
             @"address" : self.address,
             @"message" : self.message
             };
}

+(NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ChangeOrder";
}

@end
