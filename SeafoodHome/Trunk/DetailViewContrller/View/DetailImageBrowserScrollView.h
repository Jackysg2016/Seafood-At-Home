//
//  DetailImageBrowserScrollView.h
//  SeafoodHome
//
//  Created by btw on 14/12/22.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

// ----------------
// @name ImageModel
// ----------------
/**
 *  图片的Model
 */
@interface ImageModel : NSObject

@property (assign, nonatomic) NSInteger tag;
@property (assign, nonatomic) CGSize size;
@property (strong, nonatomic) NSURL *imageURL;

+ (ImageModel *)imageModelWithSize:(CGSize)size imageURL:(NSURL *)imageURL;

@end

// ----------------------------------
// @name DetailImageBrowserScrollView
// ----------------------------------

@class DetailImageBrowserScrollView;

/**
 *  delegate of detail image Browser scroll view
 */
@protocol DetailImageBrowserScrollViewDelegate <NSObject>

/**
 *  DetailImageBrowserScrollView某个item被点击后的回调事件
 *
 *  @param detailImageBrowserScrollView detailImageBrowserScrollView
 *  @param clickedIndex                 被点击者的索引例如：0、1、2、3
 */
- (void)detailImageBrowserScrollView:(DetailImageBrowserScrollView *)detailImageBrowserScrollView itemClickedAtIndex:(int)clickedIndex;

@end

/**
 *  详情页面的小图片浏览器
 */
@interface DetailImageBrowserScrollView : UIView
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

/**
 *  包含图片地址URL的数组，由外部提供
 */
@property (strong, nonatomic) NSArray *imagesURLArray;

/**
 *  delegate
 */
@property (assign, nonatomic) id<DetailImageBrowserScrollViewDelegate> delegate;

/**
 *  CollectionView用于显示主要的内容
 */
@property (strong, nonatomic, readonly) UICollectionView *collectionView;

/**
 *  类方法创建滚动浏览器
 *
 *  @param frame          需要设置的frame
 *  @param imagesURLArray 图片的URL Array
 *  @param delegate       需要设置的delegate
 *
 *  @return 返回DetailImageBrowserScrollView的对象
 */
+ (instancetype)detailImageBrowserScrollViewWithFrame:(CGRect)frame imagesURLArray:(NSArray *)imagesURLArray delegate:(id<DetailImageBrowserScrollViewDelegate>)delegate;

/**
 *  设置图片URL的集合和delegate
 *
 *  @param imagesURLArray 设置图片URL的集合
 *  @param delegate       delegate
 */
- (void)updateWithImagesURLArray:(NSArray *)imagesURLArray delegate:(id<DetailImageBrowserScrollViewDelegate>)delegate;

/**
 *  设置itemSpacing, lineSpacing, sectionInset。默认值分别是8.0, 8.0, UIEdgeInsetsZero
 *
 *  @param itemSpacing  itemSpacing
 *  @param lineSpacing  lineSpacing
 *  @param sectionInset sectionInset
 */
- (void)setItemSpacing:(CGFloat)itemSpacing lineSpacing:(CGFloat)lineSpacing sectionInset:(UIEdgeInsets)sectionInset;

@end
