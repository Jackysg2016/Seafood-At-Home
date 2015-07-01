//
//  LeftHomeModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/26.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "LeftHomeModel.h"

@implementation LeftHomeModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        for (NSDictionary *coverDict in dictionary[@"app_cover"]) {
            if (self.coversArray == nil) {
                self.coversArray = [[NSMutableArray alloc] init];
            }
            HomeCoverModel *coverModel = [[HomeCoverModel alloc] initWithDictionary:coverDict];
            [self.coversArray addObject:coverModel];
        }
        
        for (NSDictionary *favourBreedDict in dictionary[@"favourBreed"]) {
            if (self.favourBreedArray == nil) {
                self.favourBreedArray = [[NSMutableArray alloc] init];
            }
            LeftHomeFavourBreedModel *favourBreedModel = [[LeftHomeFavourBreedModel alloc] initWithDictionary:favourBreedDict];
            [self.favourBreedArray addObject:favourBreedModel];
        }
        
        for (NSString *telString in dictionary[@"telNumber"]) {
            if (self.telNumberArray == nil) {
                self.telNumberArray = [[NSMutableArray alloc] init];
            }
            [self.telNumberArray addObject:telString];
        }
    }
    return self;
}

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/jsonleft.aspx";
}

@end
