//
//  DataEmptyBackTryViewFactory.m
//  SeafoodHome
//
//  Created by btw on 15/3/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "DataEmptyBackTryViewFactory.h"
#import "DataEmptyBackTryView.h"

@implementation DataEmptyBackTryViewFactory

- (TryView <TryView> *)tryViewWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack {
    TryView <TryView> *tryView = [[DataEmptyBackTryView alloc] initWithTargetView:targetView clickedCallBack:clickedCallBack];
    [tryView setLightTextColor];
    return tryView;
}

@end
