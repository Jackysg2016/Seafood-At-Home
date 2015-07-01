//
//  ImageModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/22.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  图片的Model
 */
@interface ImageModel : NSObject

@property (assign, nonatomic) CGSize size;
@property (strong, nonatomic) NSURL *imageURL;

+ (ImageModel *)imageModelWithSize:(CGSize)size imageURL:(NSURL *)imageURL;

@end
