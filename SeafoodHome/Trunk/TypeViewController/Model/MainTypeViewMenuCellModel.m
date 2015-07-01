//
//  MainTypeViewMenuCellModel.m
//  SeafoodHome
//
//  Created by btw on 14/12/18.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainTypeViewMenuCellModel.h"

@implementation MainTypeViewMenuCellModel

+ (MainTypeViewMenuCellModel *)modelWithTitle:(NSString *)title detail:(NSString *)detail
{
    MainTypeViewMenuCellModel *model = [[MainTypeViewMenuCellModel alloc] init];
    model.title = title;
    model.detail = detail;
    return model;
}

@end
