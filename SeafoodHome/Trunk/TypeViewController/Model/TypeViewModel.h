//
//  SuperTypeModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubTypeModel.h"
#import "SFModelProtocol.h"

/** 大类 */
@interface TypeViewModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) int superTypeID;
@property (strong, nonatomic) NSString *superTypeName;
@property (assign, nonatomic) int remark;
/** 包含很多SubTypeModel */
@property (strong, nonatomic) NSMutableArray *subTypesArray;

@end
