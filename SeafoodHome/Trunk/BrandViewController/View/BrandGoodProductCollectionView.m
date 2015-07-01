//
//  BrandGoodProductCollectionView.m
//  SeafoodHome
//
//  Created by btw on 15/1/5.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "BrandGoodProductCollectionView.h"
#import "BrandGoodProductCollectionViewCell.h"

static NSString * const kCellIdentity = @"BrandGoodProductCollectionViewCell";

@implementation BrandGoodProductCollectionView {
    NSArray *_modelsArray;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor clearColor];
    
    [self registerNib:NIB_NAMED([BrandGoodProductCollectionViewCell class]) forCellWithReuseIdentifier:kCellIdentity];
}

- (void)updateWithModelsArray:(NSArray *)modelsArray {
    _modelsArray = modelsArray;
    [self reloadData];
}


#pragma mark- UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BrandGoodProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentity forIndexPath:indexPath];
    [cell updateWithModel:_modelsArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [BrandGoodProductCollectionViewCell size];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(_targetDelegate) [_targetDelegate collectionView:self didSelectItemAtIndex:(int)indexPath.row];
}

@end
