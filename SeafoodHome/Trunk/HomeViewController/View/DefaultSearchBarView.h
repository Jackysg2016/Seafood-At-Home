//
//  DefaultSearchBarView.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultSearchTextField.h"

@class FXBlurView;

@class DefaultSearchBarView;

@protocol DefaultSearchBarViewDelegate <NSObject>

/**
 *  DefaultSearchBarView 搜索回调的方法
 *
 *  @param defaultSearchBarView   发出此方法的defaultSearchBarView
 *  @param searchText             搜索文本
 */
- (void)defaultSearchBarView:(DefaultSearchBarView *)defaultSearchBarView searchText:(NSString *)searchText;

@end

@interface DefaultSearchBarView : UIView <UITextFieldDelegate>

/**
 *  模态视图，用来遮挡内容，并且提供轻敲结束输入。
 */
@property (nonatomic, strong) FXBlurView *blackBackgroudView;

/**
 *  DefaultSearchTextField是一个输入文本域
 */
@property (nonatomic, strong) DefaultSearchTextField *defaultSearchTextField;

/**
 需要设置的代理
 代理的方法方法有：
 - defaultSearchBarView:searchText:
 */
@property (nonatomic, weak) id<DefaultSearchBarViewDelegate> delegate;

@property (nonatomic, weak) UIViewController *targetVC;

- (instancetype)initWithFrame:(CGRect)frame targetVC:(UIViewController *)targetVC delegate:(id<DefaultSearchBarViewDelegate>)delegate;

- (void)blackBackgroundViewTap:(UITapGestureRecognizer *)recognizer;

/**
 *  清理文本
 */
- (void)clearText;

@end
