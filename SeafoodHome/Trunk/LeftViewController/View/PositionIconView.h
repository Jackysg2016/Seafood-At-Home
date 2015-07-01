//
//  PositionIconView.h
//  Seafood
//
//  Created by 伟明 毕 on 14/12/7.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PositionIconView;

@protocol PositionIconViewDelegate <NSObject>

/**
 *  PositionIconView点击后的回调
 *
 *  @param iconView 触发的iconView
 */
- (void)positionIconViewClicked:(PositionIconView *)iconView;

@end

/** 一个带有左边icon，右边文字的视图，它通常用于左边栏的导航条上. */
@interface PositionIconView : UIView

/**
 *  左边icon图片视图.
 */
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
/**
 *  右边文字标签.
 */
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@property (assign, nonatomic) id<PositionIconViewDelegate> delegate;

/**
 *  创建一个带有左边icon, 右边文字的视图, 它通常用于左边栏的导航条上.
 *
 *  @param frame      设置的frame.
 *  @param imageNamed 左边icon图片视图的图片名称.
 *  @param text       右边文字.
 *  @param delegate   delegate
 *
 *  @return 一个PositionIconView对象.
 */
+ (instancetype)positionIconViewWithFrame:(CGRect)frame imageNamed:(NSString *)imageNamed labelText:(NSString *)text delegate:(id<PositionIconViewDelegate>)delegate;

@end
