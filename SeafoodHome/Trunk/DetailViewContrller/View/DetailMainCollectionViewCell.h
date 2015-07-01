//
//  DetailMainCollectionViewCell.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/21.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewTypeTableHeaderView.h"
#import "StarImageView.h"
#import "HexagramImageView.h"
#import "DetailMainCollectionViewCellModel.h"
#import "DetailImageBrowserScrollView.h"
#import "StrikeThroughLabel.h"

typedef NS_ENUM(NSUInteger, DetailMainCollectionViewCellButtonType)
{
    DetailMainCollectionViewCellButtonTypeLove = 0,
    DetailMainCollectionViewCellButtonTypeUnlove,
    DetailMainCollectionViewCellButtonTypeBuy
};

@protocol DetailMainCollectionViewCellDelegate;

/**
 *  DetailCollectionView的上面部分
 */
@interface DetailMainCollectionViewCell : UICollectionViewCell <DetailImageBrowserScrollViewDelegate>

@property (assign, nonatomic) id<DetailMainCollectionViewCellDelegate> delegate;

@property (strong, nonatomic) DetailImageBrowserScrollView *detailImageBrowserScrollView;

@property (strong, nonatomic) IBOutlet StarImageView *starImageView;
@property (strong, nonatomic) IBOutlet HexagramImageView *hexagramImageView;
@property (strong, nonatomic) IBOutlet UIView *browerView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleENLabel;
@property (strong, nonatomic) IBOutlet UILabel *realPriceLabel;
@property (strong, nonatomic) IBOutlet StrikeThroughLabel *originalPriceLabel;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *unloveButton;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;

@property (strong, nonatomic) DetailMainCollectionViewCellModel *model;


- (void)updateUIWithModel:(DetailMainCollectionViewCellModel *)model delegate:(id<DetailMainCollectionViewCellDelegate>)delegate;

@end

@protocol DetailMainCollectionViewCellDelegate <NSObject>

- (void)detailMainCollectionViewCell:(DetailMainCollectionViewCell *)cell buttonClickedType:(DetailMainCollectionViewCellButtonType)type;

- (void)detailMainCollectionViewCell:(DetailMainCollectionViewCell *)cell hexagramImageViewTaped:(HexagramImageView *)imageView;

- (void)detailMainCollectionViewCell:(DetailMainCollectionViewCell *)detailMainCollectionViewCell itemClickedAtIndex:(int)index;

@end