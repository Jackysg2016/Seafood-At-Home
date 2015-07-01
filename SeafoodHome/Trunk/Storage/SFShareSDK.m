//
//  MyShareSDK.m
//  SeafoodHome
//
//  Created by btw on 15/2/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "SFShareSDK.h"
// @"http://www.sharesdk.cn"
// apple id 962663219
static NSString * const REDIRECT_URI = @"http://seafood.beautyway.com.cn/homepage/homepage.aspx";
static NSString * const SHARE_SDK_APP_KEY = @"5a0d5e93d88c";

@implementation SFShareSDK

// 此方法执行在AppDelegate
+ (void)install {
    [ShareSDK registerApp:SHARE_SDK_APP_KEY];
    
    // 添加新浪微博应用 注册网址 http://open.weibo.com
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"1301482899"
                                appSecret:@"63e6819a86552f4da67085991d57babc"
                              redirectUri:REDIRECT_URI
                              weiboSDKCls:[WeiboSDK class]];

//    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
//    [ShareSDK connectTencentWeiboWithAppKey:@"1104215351"
//                                  appSecret:@"cBhFWoVaS45rgj7o"
//                                redirectUri:REDIRECT_URI
//                                   wbApiCls:[WeiboApi class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1104215351"
                           appSecret:@"cBhFWoVaS45rgj7o"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"1104215351"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx7e8c33ed7d4d68db"   //微信APPID
                           appSecret:@"21bd8752b912c21653cff5cd4380c92c"  //微信APPSecret
                           wechatCls:[WXApi class]];
    
    //添加豆瓣应用  注册网址 http://developers.douban.com
    [ShareSDK connectDoubanWithAppKey:@"0da951beba1ef49428fbf53c2e5cddbc"
                            appSecret:@"2fa98bc5543607a2"
                          redirectUri:REDIRECT_URI];
    
    //添加人人网应用 注册网址  http://dev.renren.com
    [ShareSDK connectRenRenWithAppId:@"474984"
                              appKey:@"38a16dccf5ff45c893970c43be9d8703"
                           appSecret:@"e63403c1a6794a0d9e24186405a19812"
                   renrenClientClass:[RennClient class]];
    
    //添加开心网应用  注册网址 http://open.kaixin001.com
    [ShareSDK connectKaiXinWithAppKey:@"141714192973a55d3ff451d864abbf9f"
                            appSecret:@"999f696ded7c8cd42f3c57a31cdaf89a"
                          redirectUri:REDIRECT_URI];
    
//    // Not 申请中
//    //添加有道云笔记应用  注册网址 http://note.youdao.com/open/developguide.html#app
//    [ShareSDK connectYouDaoNoteWithConsumerKey:@"dcde25dca105bcc36884ed4534dab940"
//                                consumerSecret:@"d98217b4020e7f1874263795f44838fe"
//                                   redirectUri:@"http://www.sharesdk.cn/"];
    
    //连接短信分享
    [ShareSDK connectSMS];
    //连接邮件
    [ShareSDK connectMail];
    //连接打印
    [ShareSDK connectAirPrint];
    //连接拷贝
    [ShareSDK connectCopy];
    
}

+ (void)executeShareWithModel:(SFShareSDKModel *)model {
    if (model.URLString == nil) {
        model.URLString = REDIRECT_URI;
    }
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:model.content
                                       defaultContent:model.defaultContent
                                                image:[ShareSDK imageWithUrl:model.imageURLString]
                                                title:model.title
                                                  url:model.URLString
                                          description:model.desc
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:model.sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess) {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                } else if (state == SSResponseStateFail) {
                                    NSLog(@"%@", [NSString stringWithFormat:@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]]);
                                }
                            }];
}

@end
