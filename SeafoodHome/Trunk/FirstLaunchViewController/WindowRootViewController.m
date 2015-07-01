//
//  WindowRootViewController.m
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "WindowRootViewController.h"
#import "MainTabBarController.h"
#import "LeftNavigationController.h"
#import "MMDrawerVisualState.h"

@interface WindowRootViewController ()

@end

@implementation WindowRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 为MMDrawerController配置中部和左部视图控制器
    MainTabBarController *mainTBC = [[MainTabBarController alloc] init];
    LeftNavigationController *leftNC = [[LeftNavigationController alloc] init];

    self.leftDrawerViewController = leftNC;
    self.centerViewController = mainTBC;
    
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeTapCenterView | MMCloseDrawerGestureModePanningCenterView];
    [self setMaximumLeftDrawerWidth:AUTO_MATE_WIDTH(265)];
//    switch (arc4random() % 4) {
//        case 0:
            [self setDrawerVisualStateBlock:[MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0]];
//            break;
//        case 1:
//            [self setDrawerVisualStateBlock:[MMDrawerVisualState slideAndScaleVisualStateBlock]];
//            break;
//        case 2:
//            [self setDrawerVisualStateBlock:[MMDrawerVisualState slideVisualStateBlock]];
//            break;
//        case 3:
//            [self setDrawerVisualStateBlock:[MMDrawerVisualState swingingDoorVisualStateBlock]];
//        default:
//            break;
//    }
    [self setCenterHiddenInteractionMode:MMDrawerOpenCenterInteractionModeNone];
    [self setShouldStretchDrawer:NO];
}

@end
