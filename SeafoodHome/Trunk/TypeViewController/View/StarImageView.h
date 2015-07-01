//
//  StarImageView.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/20.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  一个包含星星的视图，用于商品列表的商家评分的显示
 */
@interface StarImageView : UIView

/**
 *  等级，用于显示多少颗星星
 */
@property (assign, nonatomic) int rank;

/**
 *  创建星星图片视图
 *
 *  @param frame 需要设置的frame
 *  @param rank  星星的等级
 *
 *  @return 星星图片视图的指针
 */
+ (instancetype)starImageViewWithFrame:(CGRect)frame rank:(int)rank;

@end
