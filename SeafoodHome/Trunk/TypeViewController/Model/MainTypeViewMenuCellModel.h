//
//  MainTypeViewMenuCellModel.h
//  SeafoodHome
//
//  Created by btw on 14/12/18.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainTypeViewMenuCellModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;

+ (MainTypeViewMenuCellModel *)modelWithTitle:(NSString *)title detail:(NSString *)detail;

@end
