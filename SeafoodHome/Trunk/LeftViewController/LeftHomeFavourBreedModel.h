//
//  LeftHomeFavourBreedModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/26.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFModelProtocol.h"

@interface LeftHomeFavourBreedModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) int breedID;
@property (assign, nonatomic) int categoryID;
@property (assign, nonatomic) NSUInteger remark;
@property (strong, nonatomic) NSString *breedTitle;

@end
