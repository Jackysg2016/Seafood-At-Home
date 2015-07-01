//
//  TipsDetailViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/28.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "MainViewController.h"
@class TipsModel;

/**
 *  贴士 -> 贴士详情视图控制器
 */
@interface TipsDetailViewController : MainViewController

@property (strong, nonatomic) TipsModel *tipModel;

- (instancetype)initWithTipModel:(TipsModel *)tipModel;

@end
