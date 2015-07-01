//
//  HomeKeyModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeADBannerModel.h"
#import "HomeBreedModel.h"
#import "HomeCoverModel.h"
#import "HomeMiddleProductListViewModel.h"
#import "SFModelProtocol.h"

@interface HomeKeyModel : NSObject <SFModelProtocol>

@property (strong, nonatomic) NSMutableArray *breedArray;
@property (strong, nonatomic) NSMutableArray *coverArray;
@property (strong, nonatomic) NSMutableArray *happyComboArray;
@property (strong, nonatomic) NSMutableArray *hotProductArray;
@property (strong, nonatomic) HomeADBannerModel *ADBannerModel;

@end
