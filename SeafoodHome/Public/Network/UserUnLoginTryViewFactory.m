//
//  UserUnLoginTryViewFactory.m
//  SeafoodHome
//
//  Created by btw on 15/3/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "UserUnLoginTryViewFactory.h"
#import "UserUnLoginTryView.h"

@implementation UserUnLoginTryViewFactory

- (TryView <TryView> *)tryViewWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack {
    TryView <TryView> *tryView = [[UserUnLoginTryView alloc] initWithTargetView:targetView clickedCallBack:clickedCallBack];
    return tryView;
}

@end
