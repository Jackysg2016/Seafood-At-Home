//
//  ProductListCollectionCellModel.m
//  SeafoodHome
//
//  Created by btw on 14/12/18.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "ListAndDetailModel.h"
#import "GGUtil.h"

@implementation ListAndDetailModel

+ (ListAndDetailModel *)modelWithDictionary:(NSDictionary *)dictionary
{
    ListAndDetailModel *model = [[ListAndDetailModel alloc] initWithDictionary:dictionary];
    return model;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.saleID = NSNotFound;
        if (dictionary[@"app_saleID"]) {
            self.saleID = [dictionary[@"app_saleID"] integerValue];
        }
        
        if (dictionary[@"app_remask"]) {
            self.remark = [dictionary[@"app_remask"] integerValue];
        }
        if (dictionary[@"app_productID"]) {
            self.productID = [dictionary[@"app_productID"] intValue];
        }
        if (dictionary[@"app_descriptionText"]) {
            self.descHTMLText = dictionary[@"app_descriptionText"];
            self.descText = [GGUtil filterHTML:dictionary[@"app_descriptionText"]];
//            self.descText = @"Gesture: Failed to receive system gesture state notification before next touch...\nGesture: Failed to receive system gesture state notification before next touch...\nGesture: Failed to receive system gesture state notification before next touch...";
        }
        if (dictionary[@"app_cnTitle"]) {
            self.cnTitle = dictionary[@"app_cnTitle"];
        }
        if (dictionary[@"app_enTitle"]) {
            self.enTitle = dictionary[@"app_enTitle"];
        }
        if (dictionary[@"app_salesPrice"]) {
            self.realPrice = [dictionary[@"app_salesPrice"] floatValue];
        }
        if (dictionary[@"app_storeCount"]) {
            self.storeCount = [dictionary[@"app_storeCount"] unsignedIntValue];
        }
        if (dictionary[@"app_coverImageURL"]) {
            self.imageURLStr = dictionary[@"app_coverImageURL"];
        }
        if (dictionary[@"app_originalPrice"]) {
            self.originalPrice = [dictionary[@"app_originalPrice"] floatValue];
        }
        if (dictionary[@"typeID"]) {
            self.typeID = [dictionary[@"typeID"] intValue];
        }
        if (dictionary[@"app_unit"]) {
            self.unit = dictionary[@"app_unit"];
        }
        if (dictionary[@"app_specification"]) {
            self.specification = dictionary[@"app_specification"];
        }
        if (dictionary[@"app_favourCount"]) {
            self.loveCount = [dictionary[@"app_favourCount"] intValue];
        }
        if (dictionary[@"app_dislikeCount"]) {
            self.unloveCount = [dictionary[@"app_dislikeCount"] intValue];
        }
        if (dictionary[@"app_star"] && [dictionary[@"app_star"] isKindOfClass:[NSNumber class]]) {
            self.rank = [dictionary[@"app_star"] intValue];
        }
        if (dictionary[@"imagesURLArray"] && [dictionary[@"imagesURLArray"] isKindOfClass:[NSArray class]]) {
            self.imagesURLArray = [[NSMutableArray alloc] init];
            for (NSString *URLStr in dictionary[@"imagesURLArray"]) {
                NSURL *imageURL = [NSURL URLWithString:URLStr];
                [self.imagesURLArray addObject:imageURL];
            }
        }
        
        if (dictionary[@"app_items"] && [dictionary[@"app_items"] isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in dictionary[@"app_items"]) {
                ListAndDetailComboItemModel *model = [[ListAndDetailComboItemModel alloc] init];
                model.productID = [dict[@"app_itemProductID"] intValue];
                model.imageURL = [NSURL URLWithString:dict[@"app_itemImageURL"]];
                [tempArray addObject:model];
            }
            self.itemsArray = tempArray;
        }
        
        if (!self.specification) {
            self.specification = [self.unit copy];
        }
        
        if (!self.unit) {
            self.unit = [self.specification copy];
        }
        
        if (self.realPrice == 0) {
            self.realPrice = self.originalPrice;
        }
        
        if (self.itemsArray && !self.imageURLStr) {
            ListAndDetailComboItemModel *model = self.itemsArray[0];
            self.imageURLStr = model.imageURL.absoluteString;
        }
        
        if (self.itemsArray) {
            self.isPorc = YES;
        } else {
            self.isPorc = NO;
        }
    }
    return self;
}
@end
