//
//  ConnectErrorBackTryView.m
//  SeafoodHome
//
//  Created by btw on 15/3/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ConnectErrorBackTryView.h"

@implementation ConnectErrorBackTryView

- (NSString *)imageNamed {
    return @"error_logo_wifi";
}

- (NSString *)labelText {
    return @"加载失败，请重新尝试！";
}

- (NSString *)buttonTitle {
    return @"点击重新加载";
}

- (NSString *)backgroundImageNamed {
    return @"left_view_bg";
}

@end
