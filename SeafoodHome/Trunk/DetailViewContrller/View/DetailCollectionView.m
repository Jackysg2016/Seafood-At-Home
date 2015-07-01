//
//  DetailCollectionView.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/21.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DetailCollectionView.h"

typedef enum : NSInteger
{
    CellTypeMain = 0,
    CellTypeText
} CellType;

static NSString * const kMainCellIdentity = @"DetailMainCollectionViewCell";
static NSString * const kTextCellIdentity = @"DetailTextCollectionViewCell";

@implementation DetailCollectionView

+ (instancetype)detailCollectionViewWithFrame:(CGRect)frame delegate:(id<DetailCollectionViewDelegate>)delegate {
    DetailCollectionView *collectionView = [[DetailCollectionView alloc] initWithFrame:frame];
    collectionView.delegate = delegate;
    return collectionView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:NIB_NAMED([DetailMainCollectionViewCell class]) forCellWithReuseIdentifier:kMainCellIdentity];
    [_collectionView registerNib:NIB_NAMED([DetailTextCollectionViewCell class]) forCellWithReuseIdentifier:kTextCellIdentity];
    [self addSubview:_collectionView];
}

- (void)setMainModel:(DetailMainCollectionViewCellModel *)mainModel {
    _mainModel = mainModel;
    [_collectionView reloadData];
}


#pragma mark- UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_mainModel) {
        return 2;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (CellTypeMain == indexPath.row) {
        DetailMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMainCellIdentity forIndexPath:indexPath];
        [cell updateUIWithModel:_mainModel delegate:self];
        return cell;
    } else if(CellTypeText == indexPath.row) {
        DetailTextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTextCellIdentity forIndexPath:indexPath];
//        [cell.moreButton addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        DetailTextCollectionViewCellModel *model = [[DetailTextCollectionViewCellModel alloc] init];
        model.title = _mainModel.cnTitle;
        model.detail = _mainModel.descText;
        [cell updateWithModel:model];
        return cell;
    }
    
    return nil;
}

- (void)moreButtonClicked:(UIButton *)button {
    if (_delegate) {
        [_delegate detailCollectionViewMoreButtonClicked:self];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size;
    
    if (CellTypeMain == indexPath.row) {
        size = CGSizeMake(SCREEN_WIDTH, 623);
    } else if (CellTypeText == indexPath.row) {
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGFloat textHeight = [_mainModel.descText sizeWithFont:MyFont(13.0) constrainedToSize:CGSizeMake(SCREEN_WIDTH - 20, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping].height;
        size = CGSizeMake(SCREEN_WIDTH, 52+textHeight);
    }
    
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

#pragma mark- DetailMainCollectionViewCellDelegate

- (void)detailMainCollectionViewCell:(DetailMainCollectionViewCell *)cell buttonClickedType:(DetailMainCollectionViewCellButtonType)type {
    [_delegate detailCollectionView:self buttonClickedType:type];
}

- (void)detailMainCollectionViewCell:(DetailMainCollectionViewCell *)cell hexagramImageViewTaped:(HexagramImageView *)imageView {
    [_delegate detailCollectionView:self hexagramImageViewTaped:imageView];
}

- (void)detailMainCollectionViewCell:(DetailMainCollectionViewCell *)detailMainCollectionViewCell itemClickedAtIndex:(int)index {
    [_delegate detailCollectionView:self itemClickedAtIndex:index];
}

@end
