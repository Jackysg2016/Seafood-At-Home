//
//  CoverModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "HomeCoverModel.h"

@implementation HomeCoverModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.imageURL = [NSURL URLWithString:dictionary[@"imageURL"]];
        self.productID = [[dictionary objectForKey:@"productID"] intValue];
        self.remark = [dictionary[@"remark"] intValue];
    }
    return self;
}

@end
