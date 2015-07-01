//
//  ShoppingCarOrderUnionPayResultModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/21.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarOrderUnionPayResultModel.h"

@implementation ShoppingCarOrderUnionPayResultModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.tnNumber = dictionary[@"tn"];
        self.message = dictionary[@"remark"];
    }
    return self;
}

@end
