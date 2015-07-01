//
//  ShoppingCarOrderUnionPayModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/21.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPostAPIProtocol.h"

/** 订单的银联支付 Post Model */
@interface ShoppingCarOrderUnionPayModel : NSObject <SFPostAPIProtocol>

@property (assign, nonatomic) int orderID;

@end
