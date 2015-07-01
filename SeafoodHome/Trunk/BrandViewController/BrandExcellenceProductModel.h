//
//  BrandExcellenceProductModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandExcellenceProductModel : NSObject

@property (assign ,nonatomic) int productID;
@property (strong ,nonatomic) NSString *cnTitle;
@property (strong, nonatomic) NSString *enTitle;
@property (strong, nonatomic) NSURL *imageURL;
@property (assign, nonatomic) float price;
@property (strong, nonatomic) NSString *unit;

@end
