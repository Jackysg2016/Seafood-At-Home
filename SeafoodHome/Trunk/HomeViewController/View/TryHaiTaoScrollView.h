//
//  TryHaiTaoScrollView.h
//  SeafoodHome
//
//  Created by btw on 14/12/10.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailImageBrowserScrollView.h"
@class TryHaiTaoScrollView;

/**
 *  Try the real "Hai Tao" 试一试真正的海淘，滚动视图的代理
 */
@protocol TryHaiTaoScrollViewDelegate <NSObject>

/**
 *  试一试真正的海淘，滚动视图点击某项后回调此方法.
 *
 *  @param tryHaiTaoScrollView 当前的tryHaiTaoScrollView
 *  @param clickedIndex        点击了哪项的索引
 */
- (void)tryHaiTaoScrollView:(TryHaiTaoScrollView *)tryHaiTaoScrollView clickedIndex:(int)clickedIndex;

@end

/**
 *  Try the real "Hai Tao" 试一试真正的海淘，滚动视图
 */
@interface TryHaiTaoScrollView : UIView
<
    DetailImageBrowserScrollViewDelegate
>

/**
 *  scrollView是一个主体内容
 */
@property (nonatomic, strong) DetailImageBrowserScrollView *scrollView;

/**
 *  一个包含所需要显示的图片地址的数组
 */
@property (nonatomic, strong) NSArray *imageURLArray;

/**
 *  视图的代理
 */
@property (nonatomic, assign) id<TryHaiTaoScrollViewDelegate> delegate;

/**
 *   创建试一试试一试真正的海淘，滚动视图的工厂方法
 *
 *  @param frame    需要设置的frame
 *  @param delegate 需要设置的代理
 *  @param images   设置一个包含所需要显示的图片地址的数组
 *
 *  @return 试一试真正的海淘，滚动视图的对象
 */
+ (instancetype)tryHaiTaoScrollViewWithFrame:(CGRect)frame imageURLArray:(NSArray *)imageURLArray delegate:(id<TryHaiTaoScrollViewDelegate>)delegate;

@end
