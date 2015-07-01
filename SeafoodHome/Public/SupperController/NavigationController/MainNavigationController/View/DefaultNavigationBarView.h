//
//  DefaultNavigationBarView.h
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  默认导航条，它的外观为黄色，通常作为各大栏目视图控制器的导航条；
 *  固定高度63
 */
@interface DefaultNavigationBarView : UIView

/**
 *  类方法创建DefaultNavigationBarView
 *
 *  @param frame 需要设置的frame
 *
 *  @return DefaultNavigationBarView的对象
 */
+ (instancetype)defaultNavigationBarViewWithFrame:(CGRect)frame;

@end
