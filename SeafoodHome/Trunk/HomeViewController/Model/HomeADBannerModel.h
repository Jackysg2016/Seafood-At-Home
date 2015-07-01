//
//  HomeADBannerModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/26.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFAPILoader.h"
#import "SFModelProtocol.h"

@interface HomeADBannerModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) int breedID;
@property (assign, nonatomic) RemarkSymbolType remark;
@property (strong, nonatomic) NSURL *imageURL;

@end
