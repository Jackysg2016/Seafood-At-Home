//
//  ReviewModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/22.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ReviewModel.h"
#import "SFUserDefaults.h"


@implementation ReviewModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.likeCount = [dictionary[@"like"] intValue];
        self.dislikeCount = [dictionary[@"dislike"] intValue];
    }
    return self;
}

+ (NSString *)APIWithReviewType:(ReviewType)reviewType productID:(int)productID isCombo:(BOOL)isCombo {
    int userID = (int)[[SFUserDefaults sharedUserDefaults] requestUserID];
    return [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=comment&comment=%d&productid=%d&remark=%d&userid=%d", (int)reviewType, productID, isCombo, userID];
}

@end
