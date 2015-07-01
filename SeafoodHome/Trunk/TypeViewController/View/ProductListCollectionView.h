//
//  ProductListCollectionView.h
//  SeafoodHome
//
//  Created by btw on 14/12/18.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductListCollectionCell.h"
#import "ProductListCollectionViewHeader.h"

typedef NS_ENUM(NSInteger, ProductListCollectionViewStyle)
{
    ProductListCollectionViewStyleGrid = 0,
    ProductListCollectionViewStyleList,
    ProductListCollectionViewStyleCombo
};

@class ProductListCollectionView;

@protocol ProductListCollectionViewDelegate;

/**
 *  产品列表CollectionView
 */
@interface ProductListCollectionView : UIView
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    ProductListCollectionCellDelegate
>

@property (strong, nonatomic) UICollectionView *collectionView;

/**
 *  包含ListAndDetailModel的数组,由外部提供
 */
@property (strong, nonatomic) NSArray *dataArray;

@property (assign, nonatomic) id<ProductListCollectionViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<ProductListCollectionViewDelegate>)delegate canShowHeaderView:(BOOL)canShowHeaderView showButton:(BOOL)showButton;

/**
 *  强制表格风格
 */
@property (assign, nonatomic) BOOL isForceGridStyle;

/**
 *  滚动到最顶部
 */
- (void)scrollToTop;

@end

@protocol ProductListCollectionViewDelegate <NSObject>

@optional
- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedItemIndex:(int)index;

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedBuyButton:(UIButton *)button index:(int)index;

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedLoveButton:(UIButton *)button index:(int)index;

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedUnloveButton:(UIButton *)button index:(int)index;

/**
 *  此代理是style为combo类型时特有的
 *
 *  @param collectionView collectionView
 *  @param productIndex   点击了的产品索引
 */
- (void)productListCollectionView:(ProductListCollectionView *)collectionView comboProductClickedIndexPath:(NSIndexPath *)indexPath;

/**
 *  当CollectionView滚动的时候出触发
 *
 *  @param collectionView collectionView
 */
- (void)productListCollectionViewDidScroll:(UICollectionView *)collectionView;

- (void)productListCollectionViewWillBeginDragging:(UICollectionView *)collectionView;

@end

