//
//  ShoppingCarChangeAmountModel.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarChangeAmountModel.h"

@implementation ShoppingCarChangeAmountModel

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ChangeShopCarNumber";
}

- (NSDictionary *)postDictionary {
    return @{
             @"shopcarid" : @(self.shopcarID),
             @"number" : @(self.number)
             };
}

@end
