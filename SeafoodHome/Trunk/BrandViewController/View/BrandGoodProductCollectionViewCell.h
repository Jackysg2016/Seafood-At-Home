//
//  BrandGoodProductCollectionViewCell.h
//  SeafoodHome
//
//  Created by btw on 15/1/5.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandExcellenceProductModel;

/** 品牌的全优单品CollectionViewCell */
@interface BrandGoodProductCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *enTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void)updateWithModel:(BrandExcellenceProductModel *)model;

+ (CGSize)size;

@end
