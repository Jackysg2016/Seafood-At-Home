//
//  LeftAddressModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/27.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "LeftAddressModel.h"

@implementation LeftAddressModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (dictionary[@"coordinate"]) {
            CLLocationDegrees latitude = [dictionary[@"coordinate"][@"latitude"] doubleValue];
            CLLocationDegrees longitude = [dictionary[@"coordinate"][@"longitude"] doubleValue];
            self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        }
        
        if (dictionary[@"shopAddress"]) {
            self.shopAddress = dictionary[@"shopAddress"];
        }
        
        if (dictionary[@"shopAddressImage"]) {
            self.shopAddressImageURL = [NSURL URLWithString:dictionary[@"shopAddressImage"]];
        }
        
        if (dictionary[@"shopName"]) {
            self.shopName = dictionary[@"shopName"];
        }
        
        for (NSString *telNumber in dictionary[@"telNumebr"]) {
            if (self.telNumberArray == nil) {
                self.telNumberArray = [[NSMutableArray alloc] init];
            }
            [self.telNumberArray addObject:telNumber];
        }
    }
    return self;
}

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/jsonAddress.aspx";
}

@end
