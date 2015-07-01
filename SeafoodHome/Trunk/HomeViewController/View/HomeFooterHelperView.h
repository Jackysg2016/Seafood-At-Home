//
//  HomeFooterMenuView.h
//  SeafoodHome
//
//  Created by btw on 14/12/11.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  通常放在首页底部的用来描述应用支持的购物支付功能
 */
@interface HomeFooterHelperView : UIView

/**
 *  工厂方法创建HomeFooterHelperView对象
 *
 *  @param frame 需要设置的frame
 *
 *  @return HomeFooterHelperView对象
 */
+ (instancetype)homeFooterHelperViewWithFrame:(CGRect)frame;

@end
