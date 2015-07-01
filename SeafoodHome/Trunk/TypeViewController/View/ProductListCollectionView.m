//
//  ProductListCollectionView.m
//  SeafoodHome
//
//  Created by btw on 14/12/18.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "ProductListCollectionView.h"
#import "SFUserDefaults.h"
#import "SFAPILoader.h"

static NSString * const kBackgroundImageNamed = @"main_bg";
static NSString * const kGridStyleCollectionCellIdentity  = @"ProductListGridStyleCollectionCell";
static NSString * const kListStyleCollectionCellIdentity  = @"ProductListListStyleCollectionCell";
static NSString * const kComboStyleCollectionCellIdentity = @"ProductListComboCollectionCell";

@interface ProductListCollectionView()
<
    MainViewTypeTableHeaderViewDelegate
>
{
    ProductListCollectionViewStyle _style;
    BOOL _isShowButton;
    BOOL _canShowHeaderView;
}

@end

@implementation ProductListCollectionView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<ProductListCollectionViewDelegate>)delegate canShowHeaderView:(BOOL)canShowHeaderView showButton:(BOOL)showButton
{
    if (self = [super initWithFrame:frame]) {
        // configuration userinter face
        self.frame = frame;
        self.delegate = delegate;
        _canShowHeaderView = canShowHeaderView;
        _isShowButton = showButton;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundImageNamed]];

        // initialization variable
        _style = [[SFUserDefaults sharedUserDefaults] productListCollectionViewStyle];
        [self initializationCollectionView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (_collectionView) {
        _collectionView.frame = self.bounds;
    }
}

- (void)initializationCollectionView
{
    // 是否显示HeaderView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.alwaysBounceVertical = YES;
    
    // Register Cell
    [_collectionView registerNib:[UINib nibWithNibName:kGridStyleCollectionCellIdentity bundle:nil] forCellWithReuseIdentifier:kGridStyleCollectionCellIdentity];
    [_collectionView registerNib:[UINib nibWithNibName:kListStyleCollectionCellIdentity bundle:nil] forCellWithReuseIdentifier:kListStyleCollectionCellIdentity];
    [_collectionView registerNib:[UINib nibWithNibName:kComboStyleCollectionCellIdentity bundle:nil] forCellWithReuseIdentifier:kComboStyleCollectionCellIdentity];
    [_collectionView registerNib:NIB_NAMED([ProductListCollectionViewHeader class]) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
    [self addSubview:_collectionView];
}

- (void)scrollToTop
{
    _collectionView.contentOffset = CGPointZero;
}

#pragma mark- UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListCollectionCell *cell = nil;
    if (_isForceGridStyle) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGridStyleCollectionCellIdentity forIndexPath:indexPath];
    } else {
        ListAndDetailModel *model = _dataArray[indexPath.row];
        if (model.itemsArray) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kComboStyleCollectionCellIdentity forIndexPath:indexPath];
        } else {
            if (ProductListCollectionViewStyleGrid == _style) {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGridStyleCollectionCellIdentity forIndexPath:indexPath];
            } else if (ProductListCollectionViewStyleList == _style) {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:kListStyleCollectionCellIdentity forIndexPath:indexPath];
            }
        }
    }
    cell.tag = indexPath.row;
    [cell updateCellWithModel:_dataArray[indexPath.row] delegate:self];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ProductListCollectionViewHeader *view = (ProductListCollectionViewHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    if (_isShowButton) {
        [view showButton];
        view.delegate = self;
    }
    
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(productListCollectionView:selectedItemIndex:)])
    [_delegate productListCollectionView:self selectedItemIndex:(int)indexPath.row];
}

#pragma mark- Configuration UISize

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (_canShowHeaderView) {
        return CGSizeMake(_collectionView.frame.size.width, [MainViewTypeTableHeaderView height]);
    }
    else {
        return CGSizeMake(0, 0);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat height = 0.0f;
    
    if (_dataArray.count > 0) {
        ListAndDetailModel *model = _dataArray[section];
        if (model.remark == RemarkSymbolTypeProducts || model.remark == RemarkSymbolTypeHotProducts) {
            if (ProductListCollectionViewStyleGrid == _style) {
                height = 10.0f;
            } else if (ProductListCollectionViewStyleList == _style) {
                height = 0.0f;
            }
        } else {
            height = 0.0f;
        }
        //    height = 10.0f;
    }
    
    return height;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = {0};
    ListAndDetailModel *model = _dataArray[indexPath.row];
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat textHeight = [model.descText sizeWithFont:MyFont(14) constrainedToSize:CGSizeMake(SCREEN_WIDTH-16, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping].height;
    if (_isForceGridStyle) {
        size = CGSizeMake(AUTO_MATE_WIDTH(160), 315);
    } else {
        if (model.itemsArray) {
            size = CGSizeMake(AUTO_MATE_WIDTH(320), 240+textHeight);
        } else {
            if (ProductListCollectionViewStyleGrid == _style) {
                size = CGSizeMake(AUTO_MATE_WIDTH(160), 315);
            } else if (ProductListCollectionViewStyleList == _style) {
                size = CGSizeMake(AUTO_MATE_WIDTH(320), 105);
            }
        }
    }
    
    return size;
}

#pragma mark- Override Method

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;

    [_collectionView reloadData];
}

#pragma mark- ProductListCollectionCellDelegate

- (void)productListCollectionCell:(ProductListCollectionCell *)cell buyButtonClicked:(UIButton *)buyButton {
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    if ([_delegate respondsToSelector:@selector(productListCollectionView:selectedBuyButton:index:)]) {
            [_delegate productListCollectionView:self selectedBuyButton:buyButton index:(int)indexPath.row];
        }
}

- (void)productListCollectionCell:(ProductListCollectionCell *)cell loveButtonClicked:(UIButton *)loveButton {
     NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    if ([_delegate respondsToSelector:@selector(productListCollectionView:selectedLoveButton:index:)])
    [_delegate productListCollectionView:self selectedLoveButton:loveButton index:(int)indexPath.row];
}

- (void)productListCollectionCell:(ProductListCollectionCell *)cell unloveButtonClicked:(UIButton *)unloveButton {
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    if ([_delegate respondsToSelector:@selector(productListCollectionView:selectedUnloveButton:index:)])
    [_delegate productListCollectionView:self selectedUnloveButton:unloveButton index:(int)indexPath.row];
}

- (void)productListCollectionCell:(ProductListCollectionCell *)cell comboProductClicked:(int)productIndex {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:productIndex inSection:cell.tag];
    if ([_delegate respondsToSelector:@selector(productListCollectionView:comboProductClickedIndexPath:)])
    [_delegate productListCollectionView:self comboProductClickedIndexPath:indexPath];
}

#pragma mark- MainViewTypeTableHeaderViewDelegate
- (void)mainViewTypeTableHeaderView:(MainViewTypeTableHeaderView *)headerView listStyleButtonClicked:(UIButton *)button type:(ListStyleButtonType)type {
    if (type == ListStyleButtonTypeGrid) {
        _style = ProductListCollectionViewStyleGrid;
    } else {
        _style = ProductListCollectionViewStyleList;
    }
    [_collectionView reloadData];
}

#pragma mark- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if([_delegate respondsToSelector:@selector(productListCollectionViewDidScroll:)]) {
        [_delegate productListCollectionViewDidScroll:_collectionView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(productListCollectionViewWillBeginDragging:)]) {
        [_delegate productListCollectionViewWillBeginDragging:_collectionView];
    }
}

@end
