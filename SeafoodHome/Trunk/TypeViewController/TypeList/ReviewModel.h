//
//  ReviewModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/22.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFModelProtocol.h"

typedef NS_ENUM(NSUInteger, ReviewType) {
    ReviewTypeLike = 0,
    ReviewTypeDislike
};

/** 点赞和踩的功能 */
@interface ReviewModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) int likeCount;
@property (assign, nonatomic) int dislikeCount;

+ (NSString *)APIWithReviewType:(ReviewType)reviewType productID:(int)productID isCombo:(BOOL)isCombo;

@end
