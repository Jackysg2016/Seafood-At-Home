//
//  ShoppingCarChangeOrderModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPostAPIProtocol.h"

/** 修改订单的信息的Post Model。 */
@interface ShoppingCarChangeOrderModel : NSObject <SFPostAPIProtocol>

@property (assign, nonatomic) int orderID;
@property (strong, nonatomic) NSString *realName;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *message;

@end
