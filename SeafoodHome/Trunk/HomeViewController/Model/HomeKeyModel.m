//
//  HomeKeyModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "HomeKeyModel.h"

@implementation HomeKeyModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.breedArray = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDict in dict[@"app_breed"]) {
            HomeBreedModel *model = [[HomeBreedModel alloc] init];
            model.breedID = [tempDict[@"breedID"] intValue];
            model.imageURL = [NSURL URLWithString:tempDict[@"imageURL"]];
            model.remark = [[tempDict objectForKey:@"remark"] integerValue];
            [self.breedArray addObject:model];
        }
        
        self.coverArray = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDict in dict[@"app_cover"]) {
            HomeCoverModel *model = [[HomeCoverModel alloc] initWithDictionary:tempDict];
            [self.coverArray addObject:model];
        }
        
        self.hotProductArray = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDict in dict[@"app_hotProduct"]) {
            HomeMiddleProductListViewModel *model = [[HomeMiddleProductListViewModel alloc] init];
            model.title = tempDict[@"title"];
            model.imageURL = [NSURL URLWithString:tempDict[@"imageURL"]];
            model.productID = [[tempDict objectForKey:@"productID"] intValue];
            [self.hotProductArray addObject:model];
        }
        
        self.happyComboArray = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDict in dict[@"app_happyCombo"]) {
            HomeMiddleProductListViewModel *model = [[HomeMiddleProductListViewModel alloc] init];
            model.title = tempDict[@"title"];
            model.imageURL = [NSURL URLWithString:tempDict[@"imageURL"]];
            NSLog(@"%@", model.imageURL);
            model.breedID = [[tempDict objectForKey:@"breedID"] intValue];
            [self.happyComboArray addObject:model];
        }
        
        self.ADBannerModel = [[HomeADBannerModel alloc] initWithDictionary:dict[@"ADBanner"]];
    }
    return self;
}

@end
