//
//  TypeProgressViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/15.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "SFAPILoader.h"

@class SubTypeModel;

@interface TypeProgressViewController : MainViewController

/**
 *  由外部提供的子类SubTypeModel的数组
 */
@property (strong, nonatomic) NSArray *subTypeArray;

/**
 *  已经选中的子类Model
 */
@property (strong, nonatomic) SubTypeModel *selectedSubTypeModel;;

- (instancetype)initWithSubTypeArray:(NSArray *)subTypeArray selectedSubTypeModel:(SubTypeModel *)selectedSubTypeModel;

@end
