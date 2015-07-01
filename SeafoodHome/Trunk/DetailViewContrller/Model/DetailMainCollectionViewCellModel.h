//
//  DetailMainCollectionViewCellModel.h
//  SeafoodHome
//
//  Created by btw on 14/12/22.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "ListAndDetailModel.h"
#import "ListAndDetailComboItemModel.h"

@interface DetailMainCollectionViewCellModel : ListAndDetailModel

/**
 *  此数组是ComboItemModel的集合
 */
@property (strong, nonatomic) NSArray *itemModels;

+ (DetailMainCollectionViewCellModel *)modelWithDictionary:(NSDictionary *)dictionary;

@end
