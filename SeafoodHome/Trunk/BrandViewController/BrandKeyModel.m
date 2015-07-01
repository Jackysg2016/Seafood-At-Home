//
//  BrandKeyModel.m
//  SeafoodHome
//
//  Created by btw on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "BrandKeyModel.h"

@implementation BrandKeyModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.videoModel = [[BrandVideoModel alloc] init];
        self.videoModel.videoURL = [NSURL URLWithString:dictionary[@"video"][@"videoURL"]];
        self.videoModel.imageURL = [NSURL URLWithString:dictionary[@"video"][@"imageURL"]];
        
        self.headerModel = [[BrandHeaderModel alloc] init];
        self.headerModel.title = dictionary[@"header"][@"title"];
        self.headerModel.subTitle = dictionary[@"header"][@"subTitle"];
        
        self.middleModel = [[BrandMiddleModel alloc] init];
        self.middleModel.title = dictionary[@"middle"][@"title"];
        self.middleModel.subTitle = dictionary[@"middle"][@"subTitle"];
        self.middleModel.detail = dictionary[@"middle"][@"description"];
        
        self.footerModel = [[BrandFooterModel alloc] init];
        self.footerModel.title = dictionary[@"footer"][@"title"];
        self.footerModel.subTitle = dictionary[@"footer"][@"subTitle"];
        self.footerModel.detail = dictionary[@"footer"][@"description"];
        
        self.excellenceProductArray = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDict in dictionary[@"excellenceProduct"]) {
            BrandExcellenceProductModel *model = [[BrandExcellenceProductModel alloc] init];
            model.productID = [tempDict[@"productID"] intValue];
            model.imageURL = [NSURL URLWithString:tempDict[@"imageURL"]];
            model.cnTitle = tempDict[@"cnTitle"];
            model.enTitle = tempDict[@"enTitle"];
            model.price = [tempDict[@"price"] floatValue];
            model.unit = tempDict[@"unit"];
            [self.excellenceProductArray addObject:model];
        }
        
        self.characteristicComboArray = [[NSMutableArray alloc] init];
        for (NSDictionary *tempDict in dictionary[@"characteristicCombo"]) {
            BrandCharacteristicComboModel *model = [[BrandCharacteristicComboModel alloc] init];;
            model.comboID = [tempDict[@"comboID"] intValue];
            model.imageURL = [NSURL URLWithString:tempDict[@"imageURL"]];
            model.cnTitle = tempDict[@"cnTitle"];
            model.enTitle = tempDict[@"enTitle"];
            model.price = [tempDict[@"price"] floatValue];
            [self.characteristicComboArray addObject:model];
        }
    }
    return self;
}

+ (NSString *)API {
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=Brand";
}

@end
