//
//  ShoppingCarDeleteOrderModel.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarDeleteOrderModel.h"

@implementation ShoppingCarDeleteOrderModel

- (NSDictionary *)postDictionary {
    return @{
             @"orderid" : @(self.orderID)
             };
}

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=DeleteOrder";
}

@end
