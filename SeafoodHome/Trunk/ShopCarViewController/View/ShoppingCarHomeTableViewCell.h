//
//  ShoppingCarHomeTableViewCell.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/1.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HexagramImageView;
@class ShoppingCarModel;

@protocol ShoppingCarHomeTableViewCellDelegate;

/**
 *  购物篮首页的表格单元
 */
@interface ShoppingCarHomeTableViewCell : UITableViewCell

@property (strong, nonatomic) UIButton *checkBoxButton;
@property (strong, nonatomic) HexagramImageView *myImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *unitPriceLabel;
@property (strong, nonatomic) UILabel *amountLabel;
@property (strong, nonatomic) UILabel *sizeLabel;

@property (strong, nonatomic) ShoppingCarModel *model;
@property (weak, nonatomic) id<ShoppingCarHomeTableViewCellDelegate> delegate;


/**
 *  更新视图用ShoppingCarHomeTableViewCellModel
 *
 *  @param model 一个ShoppingCarHomeTableViewCellModel对象
 *  @param delegate 需要设置的Delegate
 */
- (void)updateViewWithModel:(ShoppingCarModel *)model delegate:(id<ShoppingCarHomeTableViewCellDelegate>)delegate;

/**
 *  返回Cell的高度
 *
 *  @return 返回Cell的高度
 */
+ (CGFloat)height;

@end

@protocol ShoppingCarHomeTableViewCellDelegate <NSObject>

/**
 *  代理的checkbox点击事件
 *
 *  @param cell   Cell
 *  @param model  Model
 *  @param button Button
 */
- (void)shoppingCarHomeTableViewCellCheckBoxButtonClicked:(ShoppingCarHomeTableViewCell *)cell model:(ShoppingCarModel *)model button:(UIButton *)button;

/**
 *  代理的修改数量按钮的点击事件
 *
 *  @param cell   Cell
 *  @param model  Model
 *  @param button Button
 */
- (void)shoppingCarHomeTableViewCellChangeAmountButtonClicked:(ShoppingCarHomeTableViewCell *)cell model:(ShoppingCarModel *)model button:(UIButton *)button;

@end