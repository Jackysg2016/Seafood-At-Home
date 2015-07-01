//
//  DetailCollectionView.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/21.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailMainCollectionViewCell.h"
#import "DetailTextCollectionViewCell.h"

@protocol DetailCollectionViewDelegate;

/**
 *  详情页面的根视图，一个CollectionView
 */
@interface DetailCollectionView : UIView
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    DetailMainCollectionViewCellDelegate
>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (assign, nonatomic) id<DetailCollectionViewDelegate> delegate;

@property (strong, nonatomic) DetailMainCollectionViewCellModel *mainModel;

+ (instancetype)detailCollectionViewWithFrame:(CGRect)frame delegate:(id<DetailCollectionViewDelegate>)delegate;

@end


@protocol DetailCollectionViewDelegate <NSObject>

- (void)detailCollectionView:(DetailCollectionView *)detailCollectionView buttonClickedType:(DetailMainCollectionViewCellButtonType)type;
- (void)detailCollectionView:(DetailCollectionView *)detailCollectionView hexagramImageViewTaped:(HexagramImageView *)imageView;
- (void)detailCollectionView:(DetailCollectionView *)detailCollectionView itemClickedAtIndex:(int)index;
- (void)detailCollectionViewMoreButtonClicked:(DetailCollectionView *)detailCollectionView;

@end