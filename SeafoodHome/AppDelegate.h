//
//  AppDelegate.h
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WindowRootViewController.h"
#import "MiPushSDK.h"

@interface AppDelegate : UIResponder
<
    UIApplicationDelegate,
    MiPushSDKDelegate
>

@property (strong, nonatomic) UIWindow *window;

/** 是否有网络 */
@property (assign, nonatomic) BOOL hasNetWorking;

@property (nonatomic, strong) WindowRootViewController *rootViewController;

@end

