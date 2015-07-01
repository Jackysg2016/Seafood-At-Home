//
//  LeftViewHomeHeaderCell.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/14.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger
{
    HomeHeaderViewTypeOneYuanBenefits = 0,
    HomeHeaderViewTypeFullExcellentSeafood,
    HomeHeaderViewTypeFoodGoodsTips,
    HomeHeaderViewTypeShopPosition
} HomeHeaderViewType;

@class LeftViewHomeHeaderCell;

@protocol LeftViewHomeHeaderCellDelegate <NSObject>

/**
 *  按钮点击的时候出发此事件
 *
 *  @param cell cell
 *  @param type 类型
 */
- (void)leftViewHomeHeaderCell:(LeftViewHomeHeaderCell *)cell buttonViewTapType:(HomeHeaderViewType)type;

@end

/**
 *  左视图首页的Header
 */
@interface LeftViewHomeHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *OneYuanBenefitsView;
@property (weak, nonatomic) IBOutlet UIView *FullExcellentSeafoodView;
@property (weak, nonatomic) IBOutlet UIView *FoodGoodsTipsView;
@property (weak, nonatomic) IBOutlet UIView *ShopPositionView;

@property (assign, nonatomic) id<LeftViewHomeHeaderCellDelegate> delegate;

/**
 *  更新UI用LeftHomeFavourBreedModel
 *
 *  @param modelArray 包含一些LeftHomeFavourBreedModel
 */
- (void)updateWithModelArray:(NSArray *)modelArray;

@end
