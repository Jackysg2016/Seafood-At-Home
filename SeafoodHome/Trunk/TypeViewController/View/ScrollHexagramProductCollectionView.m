//
//  ScrollHexagramProductCollectionView.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/28.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "ScrollHexagramProductCollectionView.h"

static NSString * const kCellIdentity = @"CellIdentity";

@implementation ScrollHexagramProductCollectionView

- (void)awakeFromNib
{
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentity];
    self.delegate = self;
    self.dataSource = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
   
    if ([self collectionViewLayout])
    {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)[self collectionViewLayout];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    else
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionViewLayout = layout;
    }
}

- (void)updateUIWithImagesURLDataArray:(NSArray *)imagesURLDataArray delegate:(id<ScrollHexagramProductCollectionViewDelegate>)delegate
{
    self.contentOffset = CGPointZero;
    _imagesURLDataArray = imagesURLDataArray;
    _targetDelegate = delegate;
    [self reloadData];
}

#pragma mark- UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imagesURLDataArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 8.0, 0, 8.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return AUTO_MATE_WIDTH(8.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(75.0f, self.frame.size.height);
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentity forIndexPath:indexPath];
    
    [self clearCellSubViewsWithCell:cell];
    
    NSURL *imageURL = [_imagesURLDataArray objectAtIndex:indexPath.row];
    
    /**
     *  按类型添加内容到cell.contentView
     *  @see HomeMiddleProductListType
     */
    HexagramImageView *hexagramImageView = [HexagramImageView hexagramImageViewWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height) hexagramSize:HexagramSizeMiddle imageURL:imageURL];
    [cell.contentView addSubview:hexagramImageView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_targetDelegate scrollHexagramProductCollectionView:self clickedIndex:(int)indexPath.row];
}

#pragma mark- Helper

- (void)clearCellSubViewsWithCell:(UICollectionViewCell *)cell
{
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
}

@end
