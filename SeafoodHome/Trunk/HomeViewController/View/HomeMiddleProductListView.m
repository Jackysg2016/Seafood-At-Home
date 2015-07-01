//
//  ChoicenessScrollView.m
//  SeafoodHome
//
//  Created by btw on 14/12/11.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "HomeMiddleProductListView.h"
#import "HexagramImageView.h"

static NSString * const kHomeMiddleProductListCollectionViewIdentity = @"Cell";
static NSString * const kHomeMiddleProductListViewNibName = @"HomeMiddleProductListView";

@implementation HomeMiddleProductListView

+ (instancetype)homeMiddleProductListViewWithFrame:(CGRect)frame listType:(HomeMiddleProductListType)listType models:(NSArray *)models leftText:(NSString *)leftText rightText:(NSString *)rightText delegate:(id<HomeMiddleProductListViewDelegate>)delegate
{
    HomeMiddleProductListView *view = SELF_NIB;
    view.frame = frame;
    view.listType = listType;
    view.models = models;
    view.leftText = leftText;
    view.rightText = rightText;
    view.delegate = delegate;
    return view;
}

- (void)awakeFromNib
{
    [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kHomeMiddleProductListCollectionViewIdentity];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    _myCollectionView.showsHorizontalScrollIndicator = NO;
    _myCollectionView.showsVerticalScrollIndicator = NO;
    _myCollectionView.backgroundColor = [UIColor clearColor];
    
    // 水平滚动
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)[_myCollectionView collectionViewLayout];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [_myCollectionView reloadData];
    
    // 给右边的Label添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(intoLabelTaped    :)];
    _myIntoLabel.userInteractionEnabled = YES;
    [_myIntoLabel addGestureRecognizer:tap];
}

#pragma mark-

- (void)intoLabelTaped:(UITapGestureRecognizer *)recognizer
{
    [_delegate homeMiddleProductListView:self rightLabelTap:_myIntoLabel];
}

#pragma mark-

- (void)setModels:(NSArray *)models
{
    _models = models;
    
    [_myCollectionView reloadData];
}

- (void)setLeftText:(NSString *)leftText
{
    _leftText = leftText;
    _myTitleLabel.text = leftText;
}

- (void)setRightText:(NSString *)rightText
{
    _rightText = rightText;
    _myIntoLabel.text = rightText;
}

#pragma mark- UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _models.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0f, 8.0f, 0.0f, 8.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(0, 102.0f);
    if (_listType == HomeMiddleProductListTypeChoiceness)
    {
        size.width = 70.0f;
    }
    else if (_listType == HomeMiddleProductListTypeCombo)
    {
        size.width = 120.0f;
    }
    
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeMiddleProductListCollectionViewIdentity forIndexPath:indexPath];
    
    [self clearCellSubViewsWithCell:cell];
    
    HomeMiddleProductListViewModel *model = [self currentModelWithIndexPath:indexPath];
    
    /**
     *  按类型添加内容到cell.contentView
     *  @see HomeMiddleProductListType
     */
    if (_listType == HomeMiddleProductListTypeChoiceness)
    {
        HexagramImageView *hexagramImageView = [HexagramImageView hexagramImageViewWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, 75) hexagramSize:HexagramSizeMiddle imageURL:model.imageURL];
        [cell.contentView addSubview:hexagramImageView];
        UILabel *label = [self createTitleLabelWithTopView:hexagramImageView cell:cell title:model.title];
        [label sizeToFit];
        label.width = cell.contentView.width;
    }
    else if (_listType == HomeMiddleProductListTypeCombo)
    {
        UIImageView *comboImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, 70)];
        comboImageView.contentMode = UIViewContentModeScaleAspectFill;
        comboImageView.layer.cornerRadius  = 4.0f;
        comboImageView.layer.masksToBounds = YES;
        [comboImageView sd_setImageWithURL:model.imageURL placeholderImage:WAIT_LOADING_IMAGE];
        [cell.contentView addSubview:comboImageView];
        UILabel *label = [self createTitleLabelWithTopView:comboImageView cell:cell title:model.title];
        [label sizeToFit];
        label.width = cell.contentView.width;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate homeMiddleProductListView:self clickedIndex:(int)indexPath.row];
}

#pragma mark- Helper

- (HomeMiddleProductListViewModel *)currentModelWithIndexPath:(NSIndexPath *)indexPath
{
    return _models[indexPath.row];
}

- (void)clearCellSubViewsWithCell:(UICollectionViewCell *)cell
{
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
}

- (UILabel *)createTitleLabelWithTopView:(UIView *)underTopView cell:(UICollectionViewCell *)cell title:(NSString *)titleText
{
    // 创建Label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ON_VIEW_BOTTOM(underTopView, 5), cell.contentView.frame.size.width, 30)];
    titleLabel.numberOfLines = 2;
    titleLabel.text = titleText;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = MyFont(12.0f);
    titleLabel.textColor = RGB(100, 100, 100);
    [cell.contentView addSubview:titleLabel];
    return titleLabel;
}

@end
