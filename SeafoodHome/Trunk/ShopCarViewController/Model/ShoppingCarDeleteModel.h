//
//  ShoppingCarDeleteModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPostAPIProtocol.h"

/** 删除购物篮 Post Model */
@interface ShoppingCarDeleteModel : NSObject <SFPostAPIProtocol>

// 购物篮id：idlist，购物篮id的列表，如果是多个id，用逗号隔开
// http://seafood.beautyway.com.cn/json/webjson.ashx?aim=DeleteShopCar&idlist=1,2,3
/** 购物篮id，保存例如： 1,2,3 */
@property (strong, nonatomic) NSString *idList;

@end
