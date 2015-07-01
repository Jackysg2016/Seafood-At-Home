//
//  MainViewControllerUIHelper.m
//  SeafoodHome
//
//  Created by btw on 15/3/23.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "MainViewControllerUIHelper.h"
#import "DefaultSearchBarView.h"
#import "SFUserDefaults.h"
#import "MarqueeLabel.h"

static NSString * const kBackgoundImageNamed = @"main_bg";
static NSString * const kNavLeftBtnImageNamed = @"default_nav_left_btn";
static NSString * const kNavRightBtnImageNamed = @"default_nav_right_btn";
static NSString * const kNavBackBtnImageNamed = @"nav_arrow_back";
static UIColor *NAV_YELLOW_COLOR = nil;

@interface MainViewControllerUIHelper() <SFUserDefaultsDelegate, DefaultSearchBarViewDelegate> {
    UILabel *_badgeLabel;
    MarqueeLabel *_titleLabel;
    DefaultSearchBarView *_searchBarView;
}
@end

@implementation MainViewControllerUIHelper

- (instancetype)init {
    if (self = [super init]) {
        NAV_YELLOW_COLOR = RGB(211, 132, 18);
    }
    return self;
}

// 添加导航栏元素
- (void)appendingNavElementWithType:(ViewControllerUIHelperNavElementType)NavElementType {
    if (ViewControllerUIHelperNavElementTypeSlidingMenuButton == NavElementType) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:kNavLeftBtnImageNamed] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(slidingMenuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        button.frame = CGRectMake(0, 0, 22, 22);
        self.targetVC.navigationItem.leftBarButtonItem = barButtonItem;
    } else if (ViewControllerUIHelperNavElementTypeSearchBar == NavElementType) {
        DefaultSearchBarView *defaultSearchBarView = [[DefaultSearchBarView alloc] initWithFrame:CGRectMake(0, 0, AUTO_MATE_WIDTH(210.0), 26.0) targetVC:self.targetVC delegate:self];
        self.targetVC.navigationItem.titleView = defaultSearchBarView;
        _searchBarView = defaultSearchBarView;
    } else if (ViewControllerUIHelperNavElementTypeShoppingCarButton == NavElementType) {
        [self createShoppingCarButton];
    } else if (ViewControllerUIHelperNavElementTypeBackButton == NavElementType) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:kNavBackBtnImageNamed] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        button.frame = CGRectMake(0, 0, 17.0f/2, 30.0f/2);
        self.targetVC.navigationItem.leftBarButtonItem = barButtonItem;
    }
}

// 创建购物车按钮
- (void)createShoppingCarButton {
    // 创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:kNavRightBtnImageNamed] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shoppingCarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.frame = CGRectMake(0, 0, 24, 19.5);
    button.clipsToBounds = NO;
    button.layer.masksToBounds = NO;
    self.targetVC.navigationItem.rightBarButtonItem = barButtonItem;
    
    [[SFUserDefaults sharedUserDefaults] receiveChangeShoppingCarAmountNotificationWithObserver:self];
    int shoppingCarAmount = [[SFUserDefaults sharedUserDefaults] requestShoppingCarCount];
    // 创建Badge
    UILabel *badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, -13, 18,18)];
    badgeLabel.text = [NSString stringWithFormat:@"%d", shoppingCarAmount];
    badgeLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.adjustsFontSizeToFitWidth = YES;
    badgeLabel.layer.borderWidth = 1.0f;
    badgeLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    badgeLabel.layer.masksToBounds = YES;
    badgeLabel.layer.cornerRadius = 9.0f;
    badgeLabel.backgroundColor = MAIN_YELLOW_COLOR;
    badgeLabel.textColor = [UIColor whiteColor];
    [button addSubview:badgeLabel];
    _badgeLabel = badgeLabel;
    if (shoppingCarAmount == 0) {
        _badgeLabel.hidden = YES;
    }
}

// 追加导航栏标题
- (void)appendingNavTitleWithString:(NSString *)title {
    if (_titleLabel == nil) {
        _titleLabel = [[MarqueeLabel alloc] initWithFrame:CGRectMake(0, 0, AUTO_MATE_WIDTH(210), 25)];
        _titleLabel.marqueeType = MLLeftRight;
        _titleLabel.rate = 30.0f;
        _titleLabel.textColor = NAV_YELLOW_COLOR;
        _titleLabel.font = MyFont(18.0);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        self.targetVC.navigationItem.titleView = _titleLabel;
    }
    
    _titleLabel.text = title;
}

- (void)appendingNavTitleButtonWithString:(NSString *)title selector:(SEL)selector isLeft:(BOOL)isLeft {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = MyFont(16.0f);
    button.frame = CGRectMake(0, 0, title.length * 16, 25);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:NAV_YELLOW_COLOR forState:UIControlStateNormal];
    [button addTarget:self.targetVC action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bbt = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    if (isLeft) {
        [self.targetVC.navigationItem setLeftBarButtonItem:bbt animated:YES];
    } else {
        [self.targetVC.navigationItem setRightBarButtonItem:bbt animated:YES];
    }
}

#pragma mark- Button Methods
- (void)slidingMenuButtonClicked:(UIButton *)button {
    [_searchBarView blackBackgroundViewTap:nil];
    [self.delegate UIHelper:self slidingMenuButtonClicked:button];
}

- (void)shoppingCarButtonClicked:(UIButton *)button {
    [self.delegate UIHelper:self shoppingCarButtonClicked:button];
}


- (void)backButtonClicked:(UIButton *)button {
    [self.delegate UIHelper:self backButtonClicked:button];
}

#pragma mark- SFUserDefaultDelegate
- (void)receiveChangeShoppingCarAmountNotification:(NSNotification *)notification {
    int amount = [[notification object] intValue];
    if (amount > 0) {
        _badgeLabel.hidden = NO;
        _badgeLabel.text = [NSString stringWithFormat:@"%d", amount];
    } else if (amount == 0) {
        _badgeLabel.hidden = YES;
    }
}

#pragma mark- DefaultSearchBarViewDelegate
- (void)defaultSearchBarView:(DefaultSearchBarView *)defaultSearchBarView searchText:(NSString *)searchText {
    [self.delegate UIHelper:self searchText:searchText];
    [defaultSearchBarView clearText];
}

- (void)dealloc {
    [[SFUserDefaults sharedUserDefaults] removeObserver:self];
}

@end
