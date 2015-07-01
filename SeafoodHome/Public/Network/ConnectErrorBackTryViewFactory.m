//
//  ConnectErrorBackTryViewFactory.m
//  SeafoodHome
//
//  Created by btw on 15/3/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ConnectErrorBackTryViewFactory.h"
#import "ConnectErrorBackTryView.h"

@implementation ConnectErrorBackTryViewFactory

- (TryView <TryView> *)tryViewWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack {
    TryView <TryView> *tryView = [[ConnectErrorBackTryView alloc] initWithTargetView:targetView clickedCallBack:clickedCallBack];
    [tryView setLightTextColor];
    return tryView;
}

@end
