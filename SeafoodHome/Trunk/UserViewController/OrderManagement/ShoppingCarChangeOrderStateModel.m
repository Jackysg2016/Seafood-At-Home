//
//  ShoppingCarChangeOrderStateModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/21.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarChangeOrderStateModel.h"

@implementation ShoppingCarChangeOrderStateModel

- (NSDictionary *)postDictionary {
    return @{
             @"orderid" : @(self.orderID)
             };
}

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ChangeOrderState";
}

@end
