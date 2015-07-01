//
//  ShoppingCarCreateOrderModel.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarCreateOrderModel.h"
#import "SFUserDefaults.h"

@implementation ShoppingCarCreateOrderModel

- (NSDictionary *)postDictionary {
    return @{
             @"shopcarlist" : self.shopcarList,
             @"userid" : @(self.userID),
             @"realname" : self.realName,
             @"phone" : self.phone,
             @"address" : self.address,
             @"message" : self.message
             };
}

- (int)userID {
    NSInteger userID = [[SFUserDefaults sharedUserDefaults] requestUserID];
    return (int)userID;
}

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=CreateOrder";
}

@end
