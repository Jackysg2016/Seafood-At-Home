//
//  TryViewFactory.m
//  SeafoodHome
//
//  Created by btw on 15/3/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "TryViewFactory.h"
#import "TryView.h"

@interface TryViewFactory() <TryViewFactory>

@end

@implementation TryViewFactory

- (TryView <TryView> *)createTryViewWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack {
    TryView <TryView> *tryView = (TryView <TryView> *) [targetView viewWithTag:404];
    
    if (tryView == nil) {
        tryView = [self tryViewWithTargetView:targetView clickedCallBack:clickedCallBack];
        return tryView;
    } else {
        [targetView bringSubviewToFront:tryView];
        return tryView;
    }
}

- (TryView <TryView> *)tryViewWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack {
    return nil;
}

@end
