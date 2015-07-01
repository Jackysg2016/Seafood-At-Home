//
//  ShoppingCarProductStepper.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCarModel;

/** 修改商品数量的stepper */
@interface ShoppingCarProductStepper : UIView

@property (strong, nonatomic) UIButton *ascendingButton;
@property (strong, nonatomic) UIButton *descendingButton;
@property (strong, nonatomic) UILabel *unitPriceLabel;
@property (strong, nonatomic) UILabel *sumLabel;
@property (strong, nonatomic) UITextField *amountTextField;

@property (strong, nonatomic) ShoppingCarModel *model;

- (void)updateUIWithModel:(ShoppingCarModel *)model;

+ (CGFloat)height;

+ (CGFloat)width;

@end
