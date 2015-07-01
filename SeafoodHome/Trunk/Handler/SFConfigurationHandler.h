//
//  SFConfigurationHandler.h
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Seafood Home的UI配置助手
 */
@interface SFConfigurationHandler : NSObject

/**
 *  修改账户中心的视图里面的表单的底部按钮的外观
 *  外观是黄色有圆角的样式
 *
 *  @param button 要修改的底部按钮
 */
+ (void)setUserSubViewBottomButtonUI:(UIButton *)button;

/**
 *  改账户中心的视图里面的表单的ScrollView跟视图的UI配置
 *
 *  @param scrollView  Scroll View
 *  @param sizeHeight  Size Height
 */
+ (void)setUserSubViewRootScrollViewUI:(UIScrollView *)scrollView contentSizeHeight:(CGFloat)sizeHeight parentView:(UIView *)parentView;

@end