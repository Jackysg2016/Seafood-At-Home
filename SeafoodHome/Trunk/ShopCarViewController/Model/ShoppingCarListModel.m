//
//  ShoppingCarListModel.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarListModel.h"

@implementation ShoppingCarListModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.shopcarID = [dictionary[@"shopcarid"] intValue];
        self.number = [dictionary[@"app_number"] intValue];
        self.productID = [dictionary[@"app_productID"] intValue];
        self.isPorc = [dictionary[@"app_isporc"] boolValue];
        self.cnTitle = dictionary[@"app_cnTitle"];
        self.originalPrice = [dictionary[@"app_originalPrice"] floatValue];
        self.coverImageURL = [NSURL URLWithString:dictionary[@"app_coverImageURL"]];
    }
    return self;
}

/**
    用户id： userid（int）
    每页的大小： pageSize （int）
    页码： index（int）
    排序： orderBy（string） ，默认是id排序，可以不传
 */
+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ShopCarList";
}


@end