//
//  RootNavigationController.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/6.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "RootNavigationController.h"
#import "CEExplodeAnimationController.h"

@interface RootNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>
{
    CEReversibleAnimationController *_animationController;
}
@end

@implementation RootNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
    
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0 && version < 8.0) {
        self.transitioningDelegate = self;
        _animationController = [[CEExplodeAnimationController alloc] init];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count > 1) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark- Animationing
- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForDismissedController:(UIViewController *)dismissed {
    _animationController.reverse = YES;
    return _animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForPresentedController:(UIViewController *)presented
presentingController:(UIViewController *)presenting
sourceController:(UIViewController *)source {
    _animationController.reverse = NO;
    return _animationController;
}

@end
