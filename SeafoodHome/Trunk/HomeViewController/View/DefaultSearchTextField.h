//
//  DefaultSearchTextField.h
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DefaultSearchTextField;

/**
 *  默认的搜索的TextField，它通常位于NavigationBar那里
 */
@interface DefaultSearchTextField : UITextField

/**
 *  工厂方法快速创建默认的搜索的TextField对象
 *
 *  @param frame 需要设置的frame
 *
 *  @return 默认的搜索的TextField对象对象
 */
+ (instancetype)defaultSearchTextFieldWithFrame:(CGRect)frame;


@end
