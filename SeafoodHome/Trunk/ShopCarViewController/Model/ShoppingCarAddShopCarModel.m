//
//  ShoppingCarAddShopCarModel.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarAddShopCarModel.h"
#import "SFUserDefaults.h"

@implementation ShoppingCarAddShopCarModel

- (NSDictionary *)postDictionary {
    self.userID = [[SFUserDefaults sharedUserDefaults] requestUserID];
    return @{
             @"userid" : @(_userID),
             @"productid" : @(self.productID),
             @"isporc" : @(self.isPorc),
             @"remark" : @(self.remark),
             @"amount" : @(self.amount)
             };
}

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=AddShopCar";
}

@end
