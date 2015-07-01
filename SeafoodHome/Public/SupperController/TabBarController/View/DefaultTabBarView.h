//
//  DefaultTabBarView.h
//  Seafood
//
//  Created by 伟明 毕 on 14/12/8.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DefaultTabBarView;

@protocol DefaultTabBarViewDelegate <NSObject>

/**
 *  选中Item后回调此事件
 *
 *  @param defaultTabBarView DefaultTabBarView的对象指针
 *  @param index             已经选中的Item的索引数例如：1、2、3、4
 */
- (void)defaultTabBarView:(DefaultTabBarView *)defaultTabBarView selectedIndex:(int)index;

@end

/** 默认的黑色TarBar, 高度固定是63. */
@interface DefaultTabBarView : UIView

/**
 *  DefaultTabBarView的代理
 */
@property (nonatomic, assign) id<DefaultTabBarViewDelegate> delegate;

/**
 *  创建默认的黑色TarBar
 *
 *  @param frame    需要设置的frame
 *  @param delegate 需要设置的代理
 *
 *  @return 默认的黑色TarBar的对象
 */
+ (instancetype)defaultTabBarViewWithFrame:(CGRect)frame delegate:(id<DefaultTabBarViewDelegate>)delegate;

/**
 *  设置选中了哪个item
 *
 *  @param index 索引
 */
- (void)setSelectedItemAtIndex:(int)index;

@end
