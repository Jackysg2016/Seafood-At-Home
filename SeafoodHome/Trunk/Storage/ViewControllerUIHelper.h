//
//  AbstractViewControllerUIHelper.h
//  SeafoodHome
//
//  Created by btw on 15/3/23.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  导航栏的元素
 */
typedef NS_ENUM(NSUInteger, ViewControllerUIHelperNavElementType){
    /** 左侧滑栏菜单按钮 */
    ViewControllerUIHelperNavElementTypeSlidingMenuButton = 0,
    /** 搜索条 */
    ViewControllerUIHelperNavElementTypeSearchBar,
    /** 购物篮按钮 */
    ViewControllerUIHelperNavElementTypeShoppingCarButton,
    /** 返回按钮 */
    ViewControllerUIHelperNavElementTypeBackButton
};

@class ViewControllerUIHelper;

@protocol ViewControllerUIHelper <NSObject>

/**
 *  添加导航栏元素
 *
 *  @param type 元素的类型
 */
- (void)appendingNavElementWithType:(ViewControllerUIHelperNavElementType)NavElementType;

/**
 *  添加导航栏标题
 *
 *  @param title 标题文本
 */
- (void)appendingNavTitleWithString:(NSString *)title;

/**
 *  添加导航栏标题按钮
 *
 *  @param title 标题文本
 */
- (void)appendingNavTitleButtonWithString:(NSString *)title selector:(SEL)selector isLeft:(BOOL)isLeft;

@end

@protocol ViewControllerUIHelperDelegate <NSObject>

/** 左菜单按钮回调事件 */
- (void)UIHelper:(ViewControllerUIHelper<ViewControllerUIHelper> *)UIHelper slidingMenuButtonClicked:(UIButton *)slidingMenuButton;

/** 左菜单按钮回调事件 */
- (void)UIHelper:(ViewControllerUIHelper<ViewControllerUIHelper> *)UIHelper searchText:(NSString *)searchText;

/** 左菜单按钮回调事件 */
- (void)UIHelper:(ViewControllerUIHelper<ViewControllerUIHelper> *)UIHelper backButtonClicked:(UIButton *)backButton;

/** 左菜单按钮回调事件 */
- (void)UIHelper:(ViewControllerUIHelper<ViewControllerUIHelper> *)UIHelper shoppingCarButtonClicked:(UIButton *)shoppingCarButton;

@end

/** ViewControllerUIHelper它是专门用来设置UIViewController的NAV元素的类 */
@interface ViewControllerUIHelper : NSObject

/** 事件代理 */
@property (weak, nonatomic, readwrite) UIViewController<ViewControllerUIHelperDelegate> *delegate;

/** 目标视图控制器 */
@property (weak, nonatomic, readwrite) UIViewController *targetVC;

/**
 *  初始化ViewControllerUIHelper
 *
 *  @param targetVC 目标视图控制器
 *  @param delegate 事件代理
 *
 *  @return ViewControllerUIHelper<ViewControllerUIHelper> *
 */
- (instancetype)initWithTargetViewController:(UIViewController *)targetVC delegate:(UIViewController<ViewControllerUIHelperDelegate> *)delegate;

@end
