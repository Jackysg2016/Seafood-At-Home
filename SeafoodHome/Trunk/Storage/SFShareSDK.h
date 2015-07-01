//
//  MyShareSDK.h
//  SeafoodHome
//
//  Created by btw on 15/2/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <RennSDK/RennSDK.h>
#import "SFShareSDKModel.h"


@interface SFShareSDK : NSObject

/**
 *  初始化安装，此方法执行在AppDelegate。
 */
+ (void)install;

/**
 *  执行分享操作
 *
 *  @param model SFShareSDKModel
 */
+ (void)executeShareWithModel:(SFShareSDKModel *)model;

@end
