//
//  ShoppingCarDeleteOrderModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPostAPIProtocol.h"

/** 删除订单 Post Model */
@interface ShoppingCarDeleteOrderModel : NSObject <SFPostAPIProtocol>

@property (assign, nonatomic) int orderID;

@end
