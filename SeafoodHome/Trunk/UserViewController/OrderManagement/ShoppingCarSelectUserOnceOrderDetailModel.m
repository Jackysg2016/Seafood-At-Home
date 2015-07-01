//
//  ShoppingCarSelectUserOnceOrderDetailModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/20.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarSelectUserOnceOrderDetailModel.h"

@implementation ShoppingCarSelectUserOnceOrderDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.price = [dictionary[@"price"] floatValue];
        self.productName = dictionary[@"productname"];
        self.unit = dictionary[@"app_unit"];
        self.specification = dictionary[@"app_specification"];
        self.number = [dictionary[@"number"] intValue];
        
        // extension
        self.specificationString = [NSString stringWithFormat:@"规格：%@", self.specification];
        self.numberString = [NSString stringWithFormat:@"数量：%d", self.number];
        self.priceString = [NSString stringWithFormat:@"单价：%@", PRICE_STR(self.price)];
    }
    return self;
}

@end
