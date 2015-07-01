//
//  ScrollHexagramProductCollectionView.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/28.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HexagramImageView.h"

@class ScrollHexagramProductCollectionView;

@protocol ScrollHexagramProductCollectionViewDelegate <NSObject>

- (void)scrollHexagramProductCollectionView:(ScrollHexagramProductCollectionView *)collectionView clickedIndex:(int)clickedIndex;

@end

/**
 *  六角星滚动的商品CollectionView
 */
@interface ScrollHexagramProductCollectionView : UICollectionView
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic) NSArray *imagesURLDataArray;

@property (weak, nonatomic) id<ScrollHexagramProductCollectionViewDelegate> targetDelegate;

- (void)updateUIWithImagesURLDataArray:(NSArray *)imagesURLDataArray delegate:(id<ScrollHexagramProductCollectionViewDelegate>)delegate;

@end
