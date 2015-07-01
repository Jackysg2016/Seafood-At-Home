//
//  TipsModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/28.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "TipsModel.h"

@implementation TipsModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.articleID = [dictionary[@"articleID"] intValue];
        self.title = dictionary[@"title"];
        self.createDate = dictionary[@"createDate"];
        self.detail = dictionary[@"detail"];
//        self.likeCount = [dictionary[@"like"] intValue];
//        self.dislikeCount = [dictionary[@"dislike"] intValue];
        
        for (NSDictionary *imageDict in dictionary[@"images"]) {
            if (self.imagesURL == nil) {
                self.imagesURL = [[NSMutableArray alloc] init];
            }
            TipsImageModel *imageModel = [[TipsImageModel alloc] initWithDictionary:imageDict];
            [self.imagesURL addObject:imageModel];
        }
        
        if (dictionary[@"coverImage"]) {
            self.coverImageURL = [NSURL URLWithString:dictionary[@"coverImage"]];
        }
    }
    return self;
}

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/jsonTieShi.aspx";
}

@end
