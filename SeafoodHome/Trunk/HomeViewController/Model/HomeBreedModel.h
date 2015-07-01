//
//  BreedModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFAPILoader.h"

@interface HomeBreedModel : NSObject

@property (assign, nonatomic) int breedID;
@property (strong, nonatomic) NSURL *imageURL;
@property (assign, nonatomic) RemarkSymbolType remark;

@end
