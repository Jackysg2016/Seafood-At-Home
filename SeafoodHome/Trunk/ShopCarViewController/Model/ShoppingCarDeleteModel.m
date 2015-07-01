//
//  ShoppingCarDeleteModel.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarDeleteModel.h"

@implementation ShoppingCarDeleteModel

- (NSDictionary *)postDictionary {
    return @{
             @"idlist" : self.idList
             };
}

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=DeleteShopCar";
}

@end
