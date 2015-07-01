//
//  LeftRootViewController.h
//  Seafood
//
//  Created by 伟明 毕 on 14/12/7.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "RootViewController.h"
#import "LeftViewFooterView.h"
#import "PositionIconView.h"

/**
 *  左侧滑视图控制器的父类
 */
@interface LeftViewController : RootViewController

/**
 *  底部版权视图
 */
@property (strong, nonatomic) LeftViewFooterView *footerView;

/**
 *  显示版权底部视图
 */
- (void)showFooterView;

/**
 *  隐藏版权底部视图
 */
- (void)hideFooterView;

/**
 *  导航条的当前位置的标题
 *
 *  @param title 标题
 *
 *  @return UIBarButtonItem
 */
- (UIBarButtonItem *)currentPositionLabelItemWithTitle:(NSString *)title;

/**
 *  导航条的当前位置的标题（有左边Logo）
 *
 *  @param title      标题
 *  @param imageNamed Logo
 *
 *  @return UIBarButtonItem
 */
- (UIBarButtonItem *)currentPositionLabelItemWithTitle:(NSString *)title imageNamed:(NSString *)imageNamed;

/**
 *  导航条的返回按钮的item
 *
 *  @return 导航条的返回按钮的item
 */
- (UIBarButtonItem *)backItem;

@end
