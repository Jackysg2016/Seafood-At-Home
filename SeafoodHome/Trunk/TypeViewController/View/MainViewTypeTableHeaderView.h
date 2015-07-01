//
//  MainViewTypeTableHeaderView.h
//  SeafoodHome
//
//  Created by btw on 14/12/17.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger
{
    ListStyleButtonTypeGrid,
    ListStyleButtonTypeList
}ListStyleButtonType;

@class MainViewTypeTableHeaderView;

@protocol MainViewTypeTableHeaderViewDelegate <NSObject>

/**
 *  MainViewTypeTableHeaderView 按钮点击后的回调，用于风格切换
 *
 *  @param headerView MainViewTypeTableHeaderView的对象
 *  @param button     按钮
 *  @param type       按钮的类型 ListStyleButtonType
 */
- (void)mainViewTypeTableHeaderView:(MainViewTypeTableHeaderView *)headerView listStyleButtonClicked:(UIButton *)button type:(ListStyleButtonType)type;

@end

/** 分类的头视图，他只是一个UIView */
@interface MainViewTypeTableHeaderView : UIView

/**
 *  LOGO
 */
@property (strong, nonatomic) UIImageView *imageView;

@property (assign, nonatomic) id<MainViewTypeTableHeaderViewDelegate> delegate;

/**
 *  类方法创建HeaderView
 *
 *  @param frame    需要设置的frame
 *  @param delegate 需要称为delegate的instancetype
 *
 *  @return 返回HeaderView对象
 */
+ (instancetype)mainViewTypeTableHeaderViewWithFrame:(CGRect)frame delegate:(id<MainViewTypeTableHeaderViewDelegate>)delegate;

/**
 *  隐藏切换列表的按钮
 */
- (void)hideButtons;

/**
 *  显示切换列表的按钮
 */
- (void)showButtons;

/**
 *  高度
 *
 *  @return 高度
 */
+ (CGFloat)height;

@end
