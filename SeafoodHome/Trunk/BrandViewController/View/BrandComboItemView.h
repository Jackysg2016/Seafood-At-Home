//
//  BrandComboItemView.h
//  SeafoodHome
//
//  Created by btw on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandCharacteristicComboModel;

/** 特色的套餐Item视图 */
@interface BrandComboItemView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *cnTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *enTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

- (void)updateWithModel:(BrandCharacteristicComboModel *)model;

+ (BrandComboItemView *)view;

@end
