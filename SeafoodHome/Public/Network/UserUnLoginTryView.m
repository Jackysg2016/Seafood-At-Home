//
//  UserUnLoginTryView.m
//  SeafoodHome
//
//  Created by btw on 15/3/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "UserUnLoginTryView.h"

@implementation UserUnLoginTryView

- (NSString *)imageNamed {
    return @"error_logo_user";
}

- (NSString *)labelText {
    return @"亲还没登陆，请先登陆再进行操作。";
}

- (NSString *)buttonTitle {
    return @"点击马上登陆";
}

- (NSString *)backgroundImageNamed {
    return @"main_bg";
}

@end
