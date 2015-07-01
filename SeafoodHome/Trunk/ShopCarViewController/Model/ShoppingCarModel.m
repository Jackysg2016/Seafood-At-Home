//
//  ShoppingCarHomeTableViewCellModel.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/1.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarModel.h"
#import "SFUserDefaults.h"

@implementation ShoppingCarModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.isSelected = YES;
        self.title = dictionary[@"app_cnTitle"];
        
        if (dictionary[@"shopcarid"]) {
            self.shopcarID = [dictionary[@"shopcarid"] intValue];
        }
        
        if (dictionary[@"app_productID"]) {
            self.productID = [dictionary[@"app_productID"] intValue];
        }
        
        if (dictionary[@"app_coverImageURL"]) {
            self.imageURL = [NSURL URLWithString:dictionary[@"app_coverImageURL"]];
        }
        
        if (dictionary[@"app_originalPrice"]) {
            self.unitPrice = [dictionary[@"app_originalPrice"] floatValue];
        }
        
        if (dictionary[@"app_isporc"]) {
            self.isCombo = [dictionary[@"app_isporc"] boolValue];
        }
        
        if (dictionary[@"app_number"]) {
            self.amount = [dictionary[@"app_number"] intValue];
        }
        
        if (dictionary[@"app_storeCount"]) {
            self.maximumAmount = [dictionary[@"app_storeCount"] intValue];
        }
        
        if (dictionary[@"app_specification"]) {
            self.specification = dictionary[@"app_specification"];
        }
        
        if (dictionary[@"app_remark"]) {
            self.remark = [dictionary[@"app_remark"] unsignedIntegerValue];
        }

        
        if (!self.specification || [self.specification isEqualToString:@""]) {
            self.specification = @"未知";
        }
        
        if (self.isCombo) {
            [self.title stringByAppendingString:@"(套餐)"];
        }
    }
    return self;
}

- (float)sum
{
    return self.unitPrice * self.amount;
}

+ (NSString *)API {
    int userID = (int)[[SFUserDefaults sharedUserDefaults] requestUserID];
    return [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ShopCarList&userid=%d&pageSize=1000&index=1", userID];
}

@end
