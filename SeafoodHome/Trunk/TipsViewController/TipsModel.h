//
//  TipsModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/28.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFModelProtocol.h"
#import "TipsImageModel.h"

/**
 *  Tips Model
 */
@interface TipsModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) int articleID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *createDate;
@property (strong, nonatomic) NSString *detail;
//@property (assign, nonatomic) int likeCount;
//@property (assign, nonatomic) int dislikeCount;

/**
 *  TipsImageModel 
 */
@property (strong ,nonatomic) NSMutableArray *imagesURL;

/**
 *  封面图片路径
 */
@property (strong, nonatomic) NSURL *coverImageURL;

@end
