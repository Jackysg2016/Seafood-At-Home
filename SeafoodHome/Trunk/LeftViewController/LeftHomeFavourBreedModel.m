//
//  LeftHomeFavourBreedModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/26.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "LeftHomeFavourBreedModel.h"

@implementation LeftHomeFavourBreedModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (dictionary[@"breedID"]) {
            self.breedID = [dictionary[@"breedID"] intValue];
        }
        
        if (dictionary[@"categoryID"]) {
            self.categoryID = [dictionary[@"categoryID"] intValue];
        }
        
        if (dictionary[@"breedTitle"]) {
            self.breedTitle = dictionary[@"breedTitle"];
        }
        
        if (dictionary[@"remark"]) {
            self.remark = [dictionary[@"remark"] unsignedIntegerValue];
        }
    }
    return self;
}

@end
