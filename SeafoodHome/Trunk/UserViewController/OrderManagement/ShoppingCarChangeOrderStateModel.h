//
//  ShoppingCarChangeOrderStateModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/21.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPostAPIProtocol.h"

/**
 *  修改订单的状态 Post Model
 *  它的功能貌似是从“待付款”转换到“待发货”的状态
 */
@interface ShoppingCarChangeOrderStateModel : NSObject <SFPostAPIProtocol>

@property (assign, nonatomic) int orderID;

@end
