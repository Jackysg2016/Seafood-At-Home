//
//  API.m
//  SeafoodHome
//
//  Created by btw on 15/1/8.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "API.h"

@implementation API

+ (NSString *)APIOfIPAddress
{
    return @"http://server.beautyway.com.cn/getip.ashx";
}

+ (NSString *)APIOfHome
{
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=SelectHomepageImage";
}

+ (NSString *)APIOfType
{
    return @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=AllCategoryBreed";
}

+ (NSString *)APIOfSingletonProductListWithListID:(int)listID pageNumber:(int)pageNumber
{
    return [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ProductList&size=10&idlist=%d&index=%d", listID, pageNumber];
}
@end
