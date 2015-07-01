//
//  DataEmptyTryViewFactory.m
//  SeafoodHome
//
//  Created by btw on 15/3/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "DataEmptyTryViewFactory.h"
#import "DataEmptyTryView.h"

@implementation DataEmptyTryViewFactory

- (TryView <TryView> *)tryViewWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack {
    TryView <TryView> *tryView = [[DataEmptyTryView alloc] initWithTargetView:targetView clickedCallBack:clickedCallBack];
    return tryView;
}

@end
