//
//  AppDelegate.m
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstNavigationController.h"
#import "FirstLaunchViewController.h"
#import "SFUserDefaults.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "WTRequestCenter.h"
#import "SFShareSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSLog(@"%@", NSHomeDirectory());
    
    [SFShareSDK install];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        [application registerForRemoteNotifications];
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
    
    [MiPushSDK registerMiPush:self];
    [SVProgressHUD setFont:MyFont(14.0f)];
    [SVProgressHUD setForegroundColor:[UIColor grayColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    // 判断是否第一次启动，做不同的操作
    [self judgeApplicationIsFirstLaunching];
    
    [self checkingNetwork];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark- Judge Application Is FirstLaunching

- (void)judgeApplicationIsFirstLaunching {
    // 是否已经初始化了应用程序，进入不同的视图控制器
    if ([[SFUserDefaults sharedUserDefaults] isInit]) {
        [self createRootViewController];
    } else {
        [self createFirstLaunchViewController];
    }
}

#pragma mark- Create Root View Controller

- (void)createRootViewController {
    _rootViewController = [[WindowRootViewController alloc] init];
    self.window.rootViewController = _rootViewController;
    
    // 获取购物车数量
    [[SFUserDefaults sharedUserDefaults] requestNetworkingShoppingCarCount];
}

- (void)createFirstLaunchViewController {
    FirstLaunchViewController *vc = [[FirstLaunchViewController alloc] init];
    FirstNavigationController *nav = [[FirstNavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
}

#pragma mark- 检测网络状态

// 检测网络状态
- (void)checkingNetwork {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    Reachability *reach = [Reachability reachabilityWithHostname:@"seafood.beautyway.com.cn"];
    [reach startNotifier];
    
    if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
        _hasNetWorking = YES;
    } else {
        _hasNetWorking = NO;
    }
}

// 处理事件
- (void)reachabilityChanged:(NSNotification *)notification {
    Reachability *reach = [notification object];
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == NotReachable) {
        [SVProgressHUD showErrorWithStatus:@"亲的网络不太稳定哦！"];
        _hasNetWorking = NO;
    } else {
        _hasNetWorking = YES;
    }
    // 此处还可检测当前是否处于WiFi和3G/4G网络
}

- (void)applicationWillResignActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 注册APNs成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    // 注册APNS失败.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSString *messageId = [userInfo objectForKey:@"_id_"];
    NSLog(@"%@", userInfo);
    if ([userInfo objectForKey:@"aps"]) {
        if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]) {
            NSString *alertString = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"海鲜到家提醒您：" message:alertString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    [MiPushSDK openAppNotify:messageId];
}

#pragma mark- MiPushSDKDelegate
- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data {
    if ([selector isEqualToString:@"bindDeviceToken:"]) {
        NSString * regid =[data objectForKey:@"regid"];
        NSLog(@"小米ID：%@",regid);
    }
}

- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data {
    
}

// SHARESDK METHOD
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url {
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

@end
