//
//  ProductListCollectionCell.h
//  SeafoodHome
//
//  Created by btw on 14/12/18.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListAndDetailModel.h"
#import "HexagramImageView.h"
#import "StarImageView.h"
#import "StrikeThroughLabel.h"
#import "ScrollHexagramProductCollectionView.h"

@class ProductListCollectionCell;

@protocol ProductListCollectionCellDelegate <NSObject>

- (void)productListCollectionCell:(ProductListCollectionCell *)cell buyButtonClicked:(UIButton *)buyButton;
- (void)productListCollectionCell:(ProductListCollectionCell *)cell unloveButtonClicked:(UIButton *)unloveButton;
- (void)productListCollectionCell:(ProductListCollectionCell *)cell loveButtonClicked:(UIButton *)loveButton;

// combo 特有的
@optional
- (void)productListCollectionCell:(ProductListCollectionCell *)cell comboProductClicked:(int)productIndex;


@end

/**
 *  分类页面的产品列表的页面，有两种类型(xib)的CollectionCell
 *  分别是ProductListGridStyleCollectionCell和ProductListListStyleCollectionCell
 */
@interface ProductListCollectionCell : UICollectionViewCell
<
    ScrollHexagramProductCollectionViewDelegate
>

@property (weak, nonatomic) IBOutlet StarImageView *starView;
@property (strong, nonatomic) IBOutlet HexagramImageView *hexagramImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleCNLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleENLabel;
@property (weak, nonatomic) IBOutlet UILabel *realPriceLabel;
@property (weak, nonatomic) IBOutlet StrikeThroughLabel *originalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *unLoveButton;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

// 套餐特有的属性
@property (strong, nonatomic) IBOutlet ScrollHexagramProductCollectionView *comboProductListCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;


@property (assign, nonatomic) id<ProductListCollectionCellDelegate> delegate;

- (void)updateCellWithModel:(ListAndDetailModel *)model delegate:(id<ProductListCollectionCellDelegate>)delegate;


@end
