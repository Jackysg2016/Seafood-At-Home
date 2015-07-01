//
//  MainViewController.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/7.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "MainNavigationController.h"
#import "UIViewController+MMDrawerController.h"
#import "ShoppingCarViewController.h"
#import "DefaultTabBarView.h"
#import "SFUserDefaults.h"
#import "UserPrefixNavController.h"
#import "TypeListViewController.h"
#import "MainViewControllerUIHelper.h"

static NSString * const kBackgoundImageNamed = @"main_bg";
static NSString * const kNavLeftBtnImageNamed = @"default_nav_left_btn";
static NSString * const kNavRightBtnImageNamed = @"default_nav_right_btn";
static NSString * const kNavBackBtnImageNamed = @"nav_arrow_back";

#define NAV_YELLOW_COLOR RGB(211, 132, 18)

@interface MainViewController () <DefaultTabBarViewDelegate, ViewControllerUIHelperDelegate> {
    DefaultTabBarView *_tabBarView;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _UIHelper = [[MainViewControllerUIHelper alloc] initWithTargetViewController:self delegate:self];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kBackgoundImageNamed]];
    
    if (self.isShowTabBar) {
        [self createTabBar];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if(_tabBarView) {
        [self changeTabBarFrame];
        [self.view bringSubviewToFront:_tabBarView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(_tabBarView) {
        [self changeTabBarFrame];
    }

}

- (void)createTabBar {
    // 如果开启了个人热点，需要状态栏由原来的20变成40，需要获取差值，调整TabBar的offsetY
    CGFloat differenceHeight = STATUS_BAR_HEIGHT - 20.0f;
    _tabBarView = [DefaultTabBarView defaultTabBarViewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 63.0f - differenceHeight - 64, SCREEN_WIDTH, 63.0f) delegate:self];
    [self.view addSubview:_tabBarView];
    int selectedIndex = (int)[self.navigationController.tabBarController.viewControllers indexOfObject:self.navigationController];
    [_tabBarView setSelectedItemAtIndex:selectedIndex];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabBarFrame) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
}

- (void)changeTabBarFrame {
    // 如果开启了个人热点，需要状态栏由原来的20变成40，需要获取差值，调整TabBar的offsetY
    CGFloat differenceHeight = STATUS_BAR_HEIGHT - 20.0f;
    _tabBarView.frame = CGRectMake(0, SCREEN_HEIGHT - 63.0f - differenceHeight - 64, SCREEN_WIDTH, 63.0f);
}

#pragma mark- DefaultTabBarViewDelegate
- (void)defaultTabBarView:(DefaultTabBarView *)defaultTabBarView selectedIndex:(int)index {
    self.navigationController.tabBarController.selectedIndex = index;
}

#pragma mark- ViewControllerUIHelperDelegate
- (void)UIHelper:(ViewControllerUIHelper<ViewControllerUIHelper> *)UIHelper slidingMenuButtonClicked:(UIButton *)slidingMenuButton {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    // 隐藏所有键盘
    [self hideAllKeyboards];
}

- (void)UIHelper:(ViewControllerUIHelper<ViewControllerUIHelper> *)UIHelper searchText:(NSString *)searchText {
    NSString *APIName = [[SFAPILoader remarkTypeDictionary] objectForKey:@(RemarkSymbolTypeProducts)];
    NSString *APIFormat = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=%@&ProductName=%@&size=16&index=", APIName, searchText];
    TypeListViewController *typeListVC = [[TypeListViewController alloc] initWithAPIFormat:APIFormat remark:RemarkSymbolTypeProducts];
    typeListVC.searchKey = searchText;
    [self.navigationController pushViewController:typeListVC animated:YES];
}

- (void)UIHelper:(ViewControllerUIHelper<ViewControllerUIHelper> *)UIHelper backButtonClicked:(UIButton *)backButton {
    if(self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)UIHelper:(ViewControllerUIHelper<ViewControllerUIHelper> *)UIHelper shoppingCarButtonClicked:(UIButton *)shoppingCarButton {
    if (![[SFUserDefaults sharedUserDefaults] isLogined]) {
        UserPrefixNavController *nav = [[UserPrefixNavController alloc] init];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    ShoppingCarViewController *vc = [[ShoppingCarViewController alloc] init];
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark- Helper

// 隐藏所有键盘
- (void)hideAllKeyboards {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView canResignFirstResponder]) {
                    [subView resignFirstResponder];
                }
            }
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
}

@end
