//
//  SinglenessProductImageView.h
//  SeafoodHome
//
//  Created by btw on 14/12/12.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 带有白色border的ImageView */
@interface SinglenessProductImageView : UIView

/**
 *  图像视图
 */
@property (strong, nonatomic) UIImageView *imageView;

/**
 *  图像的URL
 */
@property (strong, nonatomic) NSURL *imageURL;

/**
 *  工厂方法创建带有白色border的ImageView
 *
 *  @param frame    需要设置的frame
 *  @param imageURL 需要设置的imageURL
 *
 *  @return SinglenessProductImageView的对象
 */
+ (instancetype)singlenessProductImageViewWithFrame:(CGRect)frame imageURL:(NSURL *)imageURL;

@end