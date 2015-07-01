//
//  MainViewController.h
//  Seafood
//
//  Created by 伟明 毕 on 14/12/7.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "RootViewController.h"
#import "ViewControllerUIHelper.h"

/**
 *  主栏目的视图控制器父类，这是根类，通常是不能直接使用的！
 *  @see HomeViewController
 *  @see TypeViewController
 *  @see BrandViewController
 *  @see TipsViewController
 *  @see UserViewController
 */
@interface MainViewController : RootViewController

/**
 *  是否需要显示TabBar，默认为NO。
 */
@property (assign, nonatomic) BOOL isShowTabBar;

/**
 *  用于管理NAV元素的组件
 */
@property (strong, nonatomic, readonly) ViewControllerUIHelper<ViewControllerUIHelper> *UIHelper;

@end