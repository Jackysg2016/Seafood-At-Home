//
//  LeftViewPostionStrongCell.h
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewPositionButtonView.h"

/**
 StrongColumnType有3种类型
 */
typedef enum
{
    PositionStrongColumnTypeLocation  = 0,
    PositionStrongColumnTypeNavigation,
    PositionStrongColumnTypeTelephone
} PositionStrongColumnType;

@class LeftViewPostionStrongCell;

/**
 *  LeftViewHomeStrongColumnCellDelegate
 */
@protocol LeftViewPositionStrongCellDelegate <NSObject>

/**
 *  在LeftViewPostionStrongCell中点击按钮后回调的方法
 *
 *  @param cell 发出此代理方法的LeftViewPostionStrongCell对象
 *  @param type 按钮的类型
 */
- (void)leftViewPositionStrongCell:( LeftViewPostionStrongCell *)cell buttonViewTapType:(PositionStrongColumnType)type buttonView:(LeftViewPositionButtonView *)buttonView;

@end

// 高度 AUTO_MATE_WIDTH(72)
@interface LeftViewPostionStrongCell : UITableViewCell

/**
 *  LeftViewPostionStrongCell的代理
 *  @see LeftViewPostionStrongCell:buttonViewTapType:
 */
@property (assign, nonatomic) id<LeftViewPositionStrongCellDelegate> delegate;

- (void)createUIWithDelegate:(id<LeftViewPositionStrongCellDelegate>)delegate;

@end
