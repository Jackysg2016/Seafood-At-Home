//
//  ShoppingCarListModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFModelProtocol.h"

/** 购物篮列表Model */
@interface ShoppingCarListModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) int shopcarID;
@property (assign, nonatomic) int number;
@property (assign, nonatomic) int productID;
@property (strong, nonatomic) NSString *cnTitle;
@property (assign, nonatomic) BOOL isPorc;
@property (strong, nonatomic) NSString *specification;
@property (assign, nonatomic) float originalPrice;
@property (strong, nonatomic) NSURL *coverImageURL;

@end
