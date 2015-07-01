//
//  DetailComboViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/15.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "SFAPILoader.h"

@class ListAndDetailModel;

/** 套餐详情视图控制器 */
@interface DetailComboViewController : MainViewController

@property (strong, nonatomic) ListAndDetailModel *model;
@property (assign, nonatomic) RemarkSymbolType remark;

- (instancetype)initWithModel:(ListAndDetailModel *)model;

@end
