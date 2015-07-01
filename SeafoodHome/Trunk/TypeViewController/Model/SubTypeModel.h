//
//  SubTypeModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 小类 */
@interface SubTypeModel : NSObject

@property (assign, nonatomic) int subTypeID;
@property (assign, nonatomic) NSInteger remark;
@property (strong, nonatomic) NSString *subTypeName;

@end
