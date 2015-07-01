//
//  LeftViewHomeStrongColumnCell.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/14.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewMiddleButtonView.h"

/**
 StrongColumnType有3种类型
 */
typedef enum
{
    StrongColumnTypeShoppingCar  = 0,
    StrongColumnTypeMyAccount,
    StrongColumnTypeUserSetting
} StrongColumnType;

@class LeftViewHomeStrongColumnCell;

/**
 *  LeftViewHomeStrongColumnCellDelegate
 */
@protocol LeftViewHomeStrongColumnCellDelegate <NSObject>

/**
 *  在LeftViewHomeStrongColumnCell中点击按钮后回调的方法
 *
 *  @param cell 发出此代理方法的LeftViewHomeStrongColumnCell对象
 *  @param type 按钮的类型
 */
- (void)leftViewHomeStrongColumnCell:(UITableViewCell *)cell buttonViewTapType:(StrongColumnType)type;

@end

/**
 *  左视图中下部的3大重要栏目的Cell样式
 */
@interface LeftViewHomeStrongColumnCell : UITableViewCell

/**
 *  LeftViewHomeStrongColumnCell的代理
 *  @see leftViewHomeStrongColumnCell:buttonViewTapType:
 */
@property (assign, nonatomic) id<LeftViewHomeStrongColumnCellDelegate> delegate;

- (void)createUIWithDelegate:(id<LeftViewHomeStrongColumnCellDelegate>)delegate;

@end
