//
//  LeftRootViewController.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/7.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewController.h"

static NSString * const kBackgroundImageNamed = @"left_view_bg";

@interface LeftViewController ()
{
    BOOL _footerViewIsAction;
}
@end

@implementation LeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createBackground];
}

#pragma mark-

/** 调整ScrollView、TableView的宽度 **/
- (void)initializationScrollView
{
    [super initializationScrollView];
    self.scrollView.frame = CGRectMake(0, 0, AUTO_MATE_WIDTH(265), VIEW_SIZE.height);
}

- (void)initializationTableView
{
    [super initializationTableView];
    self.tableView.frame = CGRectMake(0, 0, AUTO_MATE_WIDTH(265), VIEW_SIZE.height);
}

// 创建背景UI
- (void)createBackground
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundImageNamed]];
}

#pragma mark- UIBarButtonItem
- (UIBarButtonItem *)currentPositionLabelItemWithTitle:(NSString *)title
{
    UILabel *leftViewNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    leftViewNavTitle.font = MyFont(16.0f);
    leftViewNavTitle.text = title;
    leftViewNavTitle.textColor = [UIColor groupTableViewBackgroundColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftViewNavTitle];
    return leftItem;
}

- (UIBarButtonItem *)currentPositionLabelItemWithTitle:(NSString *)title imageNamed:(NSString *)imageNamed
{
    PositionIconView *iconView = [PositionIconView positionIconViewWithFrame:CGRectMake(0, 0, 120, 34) imageNamed:imageNamed labelText:title delegate:nil];
    UIBarButtonItem * buttonItem= [[UIBarButtonItem alloc] initWithCustomView:iconView];
    return buttonItem;
}

- (UIBarButtonItem *)backItem
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_left_arrow_white"] style:UIBarButtonItemStyleBordered target:self action:@selector(backItemButtonClicked:)];
    return backItem;
}

- (void)backItemButtonClicked:(UIBarButtonItem *)buttonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- FooterView Method

// 初始化FooterView
- (void)initializationFooterView
{
    _footerView = [LeftViewFooterView leftViewFooterViewWithFrame:CGRectMake(0, self.view.frame.size.height, AUTO_MATE_WIDTH(320-55), 50)];
    [self.view addSubview:_footerView];
    
    [self.view bringSubviewToFront:_footerView];
    _footerViewIsAction = NO;
}

- (void)showFooterView
{
    if (!_footerView) {
        [self initializationFooterView];
    }

    _footerViewIsAction = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        _footerView.frame = CGRectMake(0, self.view.frame.size.height-50, AUTO_MATE_WIDTH(320-55), 50);
    }];
}

- (void)hideFooterView {
    _footerViewIsAction = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        _footerView.frame = CGRectMake(0, self.view.frame.size.height, AUTO_MATE_WIDTH(320-55), 50);
    }];
}

#pragma mark- UIScrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    // show or hide footer view
    if (scrollView == self.tableView)
    {
        if ((0 < self.tableView.contentOffset.y) && (_footerViewIsAction == NO)) {
            [self showFooterView];
            [self performSelector:@selector(hideFooterView) withObject:nil afterDelay:4.0f];
        }
    }
}

@end
