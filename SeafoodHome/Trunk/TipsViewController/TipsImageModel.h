//
//  TipsImageModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/28.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFModelProtocol.h"

@interface TipsImageModel : NSObject <SFModelProtocol>

@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSURL *imageURL;

@end
