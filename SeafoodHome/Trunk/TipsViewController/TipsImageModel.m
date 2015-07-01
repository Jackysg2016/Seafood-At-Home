//
//  TipsImageModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/28.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "TipsImageModel.h"

@implementation TipsImageModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (dictionary[@"imageURL"]) {
            self.imageURL = [NSURL URLWithString:dictionary[@"imageURL"]];
        }
        
        if (dictionary[@"imageName"]) {
            self.imageName = dictionary[@"imageName"];
        }
        
    }
    return self;
}

@end
