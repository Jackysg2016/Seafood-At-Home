//
//  ChoicenessScrollView.h
//  SeafoodHome
//
//  Created by btw on 14/12/11.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMiddleProductListViewModel.h"

@class HomeMiddleProductListView;

typedef enum
{
    // 精品单品类型
    HomeMiddleProductListTypeChoiceness = 0,
    // kuan
    HomeMiddleProductListTypeCombo
} HomeMiddleProductListType;

@protocol HomeMiddleProductListViewDelegate <NSObject>

- (void)homeMiddleProductListView:(HomeMiddleProductListView *)listView clickedIndex:(int)clickedIndex;

- (void)homeMiddleProductListView:(HomeMiddleProductListView *)listView rightLabelTap:(UILabel *)rightLabel;

@end

/**
 *  首页中间的滚动列表视图，通常用于首页的中间部分，目前有两种类型。(HomeMiddleProductListTypeCombo | HomeMiddleProductListTypeChoiceness)
 */
@interface HomeMiddleProductListView : UIView <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/**
 *  标题Label
 */
@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;

/**
 *  点击进入的Label
 */
@property (weak, nonatomic) IBOutlet UILabel *myIntoLabel;

/**
 *  此CollectionView用来显示内容
 */
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

/**
 *  HomeMiddleProductListViewModel包含标题和图片URL
 */
@property (strong, nonatomic) NSArray *models;

/**
 *  左边标题的文字
 */
@property (strong, nonatomic) NSString *leftText;

/**
 *  右边标题的文字
 */
@property (strong, nonatomic) NSString *rightText;

/**
 *  控件的类型
 *  @see HomeMiddleProductListType
 */
@property (assign, nonatomic) HomeMiddleProductListType listType;

/**
 *  delegate
 */
@property (assign, nonatomic) id<HomeMiddleProductListViewDelegate> delegate;

/**
 *  工厂方法创建首页中间的滚动列表视图
 *
 *  @param frame     需要设置的frame
 *  @param listType  列表类型
 *  @param models    models这是HomeMiddleProductListViewModel类型的数组
 *  @param leftText  左边标题
 *  @param rightText 右边标题
 *  @param delegate  delegate
 *
 *  @return 首页中间的滚动列表视图对象
 */
+ (instancetype)homeMiddleProductListViewWithFrame:(CGRect)frame listType:(HomeMiddleProductListType)listType models:(NSArray *)models leftText:(NSString *)leftText rightText:(NSString *)rightText delegate:(id<HomeMiddleProductListViewDelegate>)delegate;

@end
