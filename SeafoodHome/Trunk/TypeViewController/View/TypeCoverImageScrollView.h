//
//  TypeCoverImageScrollView.h
//  SeafoodHome
//
//  Created by btw on 14/12/11.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFQuiltLayout.h"
#import "SinglenessProductImageView.h"

@class TypeCoverImageScrollView;

@protocol TypeCoverImageScrollViewDelegate <NSObject>

- (void)typeCoverImageScrollView:(TypeCoverImageScrollView *)typeCoverImageScrollView clickedIndex:(int)clickedIndex;

@end

/**
 *  分类封面图像滚动视图，通常位于首页显示
 */
@interface TypeCoverImageScrollView : UIView <UICollectionViewDelegate, RFQuiltLayoutDelegate, UICollectionViewDataSource>

/**
 *  TypeCoverImageScrollView的collectionView
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  一个包含图像URL的数组
 */
@property (nonatomic, strong) NSArray *imagesURL;

/**
 *  TypeCoverImageScrollView的delegate
 */
@property (nonatomic, assign) id<TypeCoverImageScrollViewDelegate> delegate;

/**
 *  工厂方法创建TypeCoverImageScrollView
 *
 *  @param imagesURL 一个包含图像URL的数组
 *  @param frame     需要设置的frame
 *  @param delegate  需要设置的代理
 *
 *  @return 返回TypeCoverImageScrollView的对象
 */
+ (instancetype)typeCoverImageScrollViewWithFrame:(CGRect)frame imagesURL:(NSArray *)imagesURL delegate:(id<TypeCoverImageScrollViewDelegate>)delegate;

@end
