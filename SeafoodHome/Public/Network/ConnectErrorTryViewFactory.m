//
//  ConnectErrorTryViewFactory.m
//  SeafoodHome
//
//  Created by btw on 15/3/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ConnectErrorTryViewFactory.h"
#import "ConnectErrorTryView.h"

@implementation ConnectErrorTryViewFactory

- (TryView <TryView> *)tryViewWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack {
    TryView <TryView> *tryView = [[ConnectErrorTryView alloc] initWithTargetView:targetView clickedCallBack:clickedCallBack];
    return tryView;
}

@end
