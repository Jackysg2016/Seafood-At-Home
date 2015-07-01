//
//  ShoppingCarHomeTableViewCellModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/1.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SFModelProtocol.h"

@interface ShoppingCarModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) BOOL isSelected;
@property (assign, nonatomic) int shopcarID;
@property (assign, nonatomic) int productID;
@property (assign, nonatomic) NSUInteger remark;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) float unitPrice;
/** 是否套餐NO是单品，YES是套餐 */
@property (assign, nonatomic) BOOL isCombo;
@property (assign, nonatomic) int amount;
@property (assign, nonatomic) int maximumAmount;
/** 商品规格 */
@property (strong, nonatomic) NSString *specification;
@property (assign, nonatomic) float sum;

/**
 *  购物篮列表ＡＰＩ
 *
 *  @return 购物篮列表ＡＰＩ
 */
+ (NSString *)API;

@end
