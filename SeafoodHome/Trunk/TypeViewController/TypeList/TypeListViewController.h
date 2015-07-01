//
//  TypeListViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/7.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "SFAPILoader.h"

@class TypeViewModel;

/**
 *  分类列表视图控制器
 */
@interface TypeListViewController : MainViewController

@property (assign, nonatomic) RemarkSymbolType remark;

/** 初始化 */
- (instancetype)initWithAPIFormat:(NSString *)APIFormat remark:(RemarkSymbolType)remark;

@property (strong, nonatomic) NSString *searchKey;

// API格式
@property (copy, nonatomic) NSString *APIFormat;

@end