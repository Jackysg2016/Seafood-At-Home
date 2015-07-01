//
//  ShoppingCarCreateOrderModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPostAPIProtocol.h"

/** 创建订单的 Post Model */
@interface ShoppingCarCreateOrderModel : NSObject <SFPostAPIProtocol>

@property (assign, nonatomic) int userID;
/** 购物篮的id列表，用逗号隔开 */
@property (strong, nonatomic) NSString *shopcarList;
@property (strong, nonatomic) NSString *realName;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *message;

@end
