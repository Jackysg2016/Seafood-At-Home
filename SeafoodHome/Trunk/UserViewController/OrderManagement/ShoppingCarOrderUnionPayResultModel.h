//
//  ShoppingCarOrderUnionPayResultModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/21.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFModelProtocol.h"

/** 银联支付返回的结果 Model */
@interface ShoppingCarOrderUnionPayResultModel : NSObject <SFModelProtocol>

@property (strong, nonatomic) NSString *tnNumber;
@property (strong, nonatomic) NSString *message;

@end
