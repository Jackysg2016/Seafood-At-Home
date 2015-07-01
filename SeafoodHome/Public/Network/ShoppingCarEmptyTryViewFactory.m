//
//  ShoppingCarEmptyTryViewFactory.m
//  SeafoodHome
//
//  Created by btw on 15/3/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarEmptyTryViewFactory.h"
#import "ShoppingCarEmptyTryView.h"

@implementation ShoppingCarEmptyTryViewFactory

- (TryView <TryView> *)tryViewWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack {
    TryView <TryView> *tryView = [[ShoppingCarEmptyTryView alloc] initWithTargetView:targetView clickedCallBack:clickedCallBack];
    return tryView;
}

@end
