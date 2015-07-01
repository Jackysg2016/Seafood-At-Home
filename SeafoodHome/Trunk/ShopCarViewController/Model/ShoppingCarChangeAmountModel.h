//
//  ShoppingCarChangeAmountModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPostAPIProtocol.h"

/** 修改购物篮数量 Post Model */
@interface ShoppingCarChangeAmountModel : NSObject <SFPostAPIProtocol>

@property (assign, nonatomic) int shopcarID;
@property (assign, nonatomic) int number;

@end
