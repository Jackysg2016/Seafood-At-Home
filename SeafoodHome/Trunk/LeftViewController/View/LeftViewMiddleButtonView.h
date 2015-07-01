//
//  LeftViewMiddleButtonView.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/14.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  左视图中下部的3大栏目的Cell里面的单个视图，主要包含一个icon和标题
 */
@interface LeftViewMiddleButtonView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageVIew;

/**
 *  工厂方法创建LeftViewMiddleButtonView
 *
 *  @param frame      需要设置的frame
 *  @param imageNamed icon的图片名（本地图片的名称）
 *  @param title      标题
 *
 *  @return LeftViewMiddleButtonView的对象
 */
+ (instancetype) leftViewMiddleButtonViewWithFrame:(CGRect)frame iconImageNamed:(NSString *)imageNamed title:(NSString *)title;

@end
