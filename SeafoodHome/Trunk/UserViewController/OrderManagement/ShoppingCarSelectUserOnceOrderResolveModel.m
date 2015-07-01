//
//  ShoppingCarSelectUserOnceOrderResolveModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/20.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarSelectUserOnceOrderResolveModel.h"

@implementation ShoppingCarSelectUserOnceOrderResolveModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.isFailAccept = [dictionary[@"app_accept"] boolValue];
        self.productName = dictionary[@"app_cnTitle"];
        self.originalPrice = [dictionary[@"app_originalPrice"] floatValue];
        self.productID = [dictionary[@"app_productID"] intValue];
        self.realPrice = [dictionary[@"app_realprice"] floatValue];
        self.realquantity = [dictionary[@"app_realquantity"] floatValue];
        self.specification = dictionary[@"app_specification"];
        self.unit = dictionary[@"app_unit"];
    
        // extension
        self.specificationString = [NSString stringWithFormat:@"规格：%@", self.specification];
        self.realPriceString = [NSString stringWithFormat:@"价格：%@", PRICE_STR(self.realPrice)];
        self.realquantityString = [NSString stringWithFormat:@"实重：%.2f", self.realquantity];
    }
    return self;
}

@end
