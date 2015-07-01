//
//  TypeCoverImageScrollView.m
//  SeafoodHome
//
//  Created by btw on 14/12/11.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "TypeCoverImageScrollView.h"
#import "TryHaiTaoScrollViewCell.h"

static NSString * const kCellIdentity = @"Cell";

@implementation TypeCoverImageScrollView

+ (instancetype)typeCoverImageScrollViewWithFrame:(CGRect)frame imagesURL:(NSArray *)imagesURL delegate:(id<TypeCoverImageScrollViewDelegate>)delegate
{
    TypeCoverImageScrollView *typeCoverImageScrollView = [[TypeCoverImageScrollView alloc] initWithFrame:frame];
    typeCoverImageScrollView.imagesURL = imagesURL;
    typeCoverImageScrollView.delegate = delegate;
    return typeCoverImageScrollView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createCollectionView];
    }
    return self;
}

- (void)createCollectionView
{
    RFQuiltLayout *layout = [[RFQuiltLayout alloc] init];
    // 划分蛋糕
    layout.blockPixels = CGSizeMake(self.frame.size.width/20.0, self.frame.size.height/ 2.0);
    layout.direction = UICollectionViewScrollDirectionHorizontal;
    layout.delegate = self; // !important
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentity];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    [self addSubview:_collectionView];
    
    _collectionView.backgroundColor = [UIColor clearColor];

}

#pragma mark-

- (void)setImagesURL:(NSArray *)imagesURL
{
    _imagesURL = imagesURL;
    
    [_collectionView reloadData];
}

#pragma mark- UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentity forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }

    CGFloat width = 0;
    if (indexPath.row % 2 == 0)
    {
        width = self.frame.size.width/20.0 * 11-8;
    }
    else
    {
        width = self.frame.size.width/20.0 * 9-8;
    }
    
    // 创建图像
    SinglenessProductImageView *imageView = [SinglenessProductImageView singlenessProductImageViewWithFrame:CGRectMake(0, 0, width, cell.contentView.frame.size.height) imageURL:_imagesURL[indexPath.row]];
    [cell.contentView addSubview:imageView];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imagesURL.count;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate typeCoverImageScrollView:self clickedIndex:(int)indexPath.row];
}

#pragma mark – RFQuiltLayoutDelegate

// 返回比例
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = 0.0;
    if(indexPath.row % 2 == 0)
    {
        width = 11;
    }
    else
    {
        width = 9;
    }
    
    return CGSizeMake(width, 1.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetsForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return UIEdgeInsetsMake(3, 3, 3, 3);
}

@end
