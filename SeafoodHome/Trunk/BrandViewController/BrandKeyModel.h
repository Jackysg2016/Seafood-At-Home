//
//  BrandKeyModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrandHeaderModel.h"
#import "BrandMiddleModel.h"
#import "BrandFooterModel.h"
#import "BrandVideoModel.h"
#import "BrandCharacteristicComboModel.h"
#import "BrandExcellenceProductModel.h"

@interface BrandKeyModel : NSObject

@property (strong, nonatomic) NSMutableArray *characteristicComboArray;
@property (strong, nonatomic) NSMutableArray *excellenceProductArray;
@property (strong, nonatomic) BrandVideoModel *videoModel;
@property (strong, nonatomic) BrandHeaderModel *headerModel;
@property (strong, nonatomic) BrandMiddleModel *middleModel;
@property (strong, nonatomic) BrandFooterModel *footerModel;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSString *)API;

@end
