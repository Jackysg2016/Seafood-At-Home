//
//  ShoppingCarAddShopCarModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPostAPIProtocol.h"

/** 购物篮添加的Post Model */
@interface ShoppingCarAddShopCarModel : NSObject <SFPostAPIProtocol>

@property (assign ,nonatomic) NSInteger userID;
@property (assign, nonatomic) NSInteger productID;
/** 0单品，1是套餐 */
@property (assign, nonatomic) BOOL isPorc;
// 0是普通单品界面，1是套餐界面，2是特惠，3是团购，今日推荐也用2，人气单品用0
@property (assign, nonatomic) NSUInteger remark;
@property (assign, nonatomic) NSInteger amount;

@end
