//
//  BrandGoodProductCollectionView.h
//  SeafoodHome
//
//  Created by btw on 15/1/5.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BrandGoodProductCollectionViewDelegate;

/** 品牌的全优单品CollectionView */
@interface BrandGoodProductCollectionView : UICollectionView
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

@property (assign, nonatomic) id<BrandGoodProductCollectionViewDelegate> targetDelegate;

- (void)updateWithModelsArray:(NSArray *)modelsArray;

@end

@protocol BrandGoodProductCollectionViewDelegate <NSObject>

- (void)collectionView:(BrandGoodProductCollectionView *)collectionView didSelectItemAtIndex:(int)index;

@end