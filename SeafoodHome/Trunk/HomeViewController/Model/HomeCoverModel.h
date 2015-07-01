//
//  CoverModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFModelProtocol.h"

/** 首页CoverModel */
@interface HomeCoverModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) int productID;
@property (strong ,nonatomic) NSURL *imageURL;
@property (assign, nonatomic) int remark;

@end
