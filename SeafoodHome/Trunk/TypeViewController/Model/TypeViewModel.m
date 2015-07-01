//
//  SuperTypeModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "TypeViewModel.h"

@implementation TypeViewModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self= [super init]) {
        self.remark = [dictionary[@"app_remark"] intValue];
        self.superTypeID = [dictionary[@"app_superTypeID"] intValue];
        self.superTypeName = dictionary[@"app_superTypeName"];
        
        self.subTypesArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in dictionary[@"app_subTypes"]) {
            SubTypeModel *model = [[SubTypeModel alloc] init];
            model.subTypeID = [dict[@"app_subTypeID"] intValue];
            model.subTypeName = dict[@"app_subTypeName"];
            model.remark = self.remark;
            [self.subTypesArray addObject:model];
        }
    }
    return self;
}

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=AllCategoryBreed";
}

@end
