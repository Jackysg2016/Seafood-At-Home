//
//  DefaultTarBarItemView.h
//  Seafood
//
//  Created by 伟明 毕 on 14/12/8.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 通常用于TabBar的一个模拟按钮Item的视图 */
@interface DefaultTabBarItemView : UIView

/**
 *  icon图标视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

/**
 *  已选择的背景视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *selectedBackgroundView;

/**
 *  创建DefaultTabBarItemView
 *
 *  @param frame      需要设置的frame
 *  @param imageNamed 本地图片名称，尾部会自动添加_normal和_light，所以需要注意！
 *  @param title      图片下面的标题
 *
 *  @return DefaultTabBarItemView对象
 */
+ (instancetype)defaultTabBarItemViewWithFrame:(CGRect)frame imageNamed:(NSString *)imageNamed title:(NSString *)title;

/**
 *  设置选择状态
 */
- (void)setSelectedState;

/**
 *  设置未选择状态
 */
- (void)setDeselectedState;

@end