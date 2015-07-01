//
//  LeftHomeModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/26.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeCoverModel.h"
#import "LeftHomeFavourBreedModel.h"

/** 左部侧滑栏首页Model */
@interface LeftHomeModel : NSObject <SFModelProtocol>

/** 包含HomeCoverModel */
@property (strong, nonatomic) NSMutableArray *coversArray;
/** 包含LeftHomeFavourBreedModel */
@property (strong, nonatomic) NSMutableArray *favourBreedArray;
/** 字符串 */
@property (strong, nonatomic) NSMutableArray *telNumberArray;

@end
