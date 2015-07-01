//
//  DetailImageBrowserScrollView.m
//  SeafoodHome
//
//  Created by btw on 14/12/22.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DetailImageBrowserScrollView.h"

@implementation ImageModel

+ (ImageModel *)imageModelWithSize:(CGSize)size imageURL:(NSURL *)imageURL
{
    ImageModel *model = [[ImageModel alloc] init];
    model.imageURL = imageURL;
    model.size = size;
    return model;
}

@end

static NSString * const kCellIdentity = @"Cell";

@implementation DetailImageBrowserScrollView
{
    CGFloat _lineHeight;
    NSMutableArray *_imageModels;
}

+ (instancetype)detailImageBrowserScrollViewWithFrame:(CGRect)frame imagesURLArray:(NSArray *)imagesURLArray delegate:(id<DetailImageBrowserScrollViewDelegate>)delegate
{
    DetailImageBrowserScrollView *detailImageBrowserScrollView = [[DetailImageBrowserScrollView alloc] initWithFrame:frame imagesURLArray:imagesURLArray];
    detailImageBrowserScrollView.delegate = delegate;
    return detailImageBrowserScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame imagesURLArray:(NSArray *)imagesURLArray
{
    if (self = [super initWithFrame:frame])
    {
        _imagesURLArray = imagesURLArray;
        _imageModels = [[NSMutableArray alloc] init];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 8.0f;
    layout.minimumLineSpacing = 8.0f;
    layout.sectionInset = UIEdgeInsetsZero;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.alwaysBounceHorizontal = YES;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentity];
    [self addSubview:_collectionView];
}

- (void)loadImages
{
    [_imageModels removeAllObjects];
    
    for (NSURL *url in _imagesURLArray) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (finished && image) {
                // 转换高度
                CGSize imageSize = image.size;
                imageSize.width = imageSize.width*self.frame.size.height/imageSize.height;
                imageSize.height = self.frame.size.height;
                
                ImageModel *model = [ImageModel imageModelWithSize:imageSize imageURL:imageURL];
                model.tag = [_imagesURLArray indexOfObject:imageURL];
                [_imageModels addObject:model];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_collectionView reloadData];
                });
            }
        }];
    }
}

- (void)updateWithImagesURLArray:(NSArray *)imagesURLArray delegate:(id<DetailImageBrowserScrollViewDelegate>)delegate {
    self.imagesURLArray = imagesURLArray;
    self.delegate = delegate;
    
    [self loadImages];
}

- (void)setItemSpacing:(CGFloat)itemSpacing lineSpacing:(CGFloat)lineSpacing sectionInset:(UIEdgeInsets)sectionInset {
    UICollectionViewFlowLayout *layout =  (UICollectionViewFlowLayout *)[_collectionView collectionViewLayout];
    layout.minimumLineSpacing = lineSpacing;
    layout.minimumInteritemSpacing = lineSpacing;
    layout.sectionInset = sectionInset;
}

#pragma mark- UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentity forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    ImageModel *model = _imageModels[indexPath.row];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, model.size.width, model.size.height)];
    imageView.layer.cornerRadius = 2.0f;
    imageView.clipsToBounds = YES;
    [cell.contentView addSubview:imageView];
    
    // 设置图片
    [imageView sd_setImageWithURL:model.imageURL placeholderImage:WAIT_LOADING_IMAGE];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageModel *model = _imageModels[indexPath.row];
    [_delegate detailImageBrowserScrollView:self itemClickedAtIndex:(int)model.tag];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageModel *model = _imageModels[indexPath.row];
    return model.size;
}

@end