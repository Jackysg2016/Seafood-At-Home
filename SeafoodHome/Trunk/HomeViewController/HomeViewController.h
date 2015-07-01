//
//  HomeViewController.h
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "TryHaiTaoScrollView.h"
#import "TypeCoverImageScrollView.h"
#import "HomeFooterHelperView.h"
#import "BWMCoverView.h"
#import "HomeMiddleProductListView.h"

/**
 *  主要栏目——首页视图控制器
 */
@interface HomeViewController : MainViewController
<
    TryHaiTaoScrollViewDelegate,
    TypeCoverImageScrollViewDelegate,
    HomeMiddleProductListViewDelegate
>


@end
