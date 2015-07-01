//
//  HomeADBannerModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/26.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "HomeADBannerModel.h"

@implementation HomeADBannerModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.breedID = [dictionary[@"breedID"] intValue];
        self.remark = [dictionary[@"remark"] unsignedIntegerValue];
        self.imageURL = [NSURL URLWithString:dictionary[@"imageURL"]];
    }
    return self;
}

@end
