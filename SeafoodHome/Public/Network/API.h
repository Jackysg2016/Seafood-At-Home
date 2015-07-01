//
//  API.h
//  SeafoodHome
//
//  Created by btw on 15/1/8.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AuthCodeUseType)
{
    AuthCodeUseTypeRegister = 0,
    AuthCodeUseTypeFindPassworkd
};

/**
 *  管理所有的网络API网址
 */
@interface API : NSObject

// IP地址
+ (NSString *)APIOfIPAddress;

// 首页的API网址
+ (NSString *)APIOfHome;

// 分类的API网址（所有分类）
+ (NSString *)APIOfType;

/**
 *  单品列表页的API网址
 *
 *  @param listID 列表的ID
 *  @param pageNumber 页数
 *
 *  @return 单品列表页的API网址字符串
 */
+ (NSString *)APIOfSingletonProductListWithListID:(int)listID pageNumber:(int)pageNumber;

@end
