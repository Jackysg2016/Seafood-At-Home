//
//  AbstractViewControllerUIHelper.m
//  SeafoodHome
//
//  Created by btw on 15/3/23.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ViewControllerUIHelper.h"

@implementation ViewControllerUIHelper

- (instancetype)initWithTargetViewController:(UIViewController *)targetVC delegate:(UIViewController<ViewControllerUIHelperDelegate> *)delegate {
    if (self = [self init]) {
        self.targetVC = targetVC;
        self.delegate = delegate;
    }
    
    return self;
}

@end
