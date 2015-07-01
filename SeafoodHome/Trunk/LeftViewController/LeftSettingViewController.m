//
//  LeftSettingViewController.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftSettingViewController.h"
#import "SFUserDefaults.h"

static NSString * const kUserSettingCellIdentity = @"UserSettingCellIdentity";

@interface LeftSettingViewController ()
{
    LeftViewUserSettingHeaderView *_tableHeaderView;
}
@end

@implementation LeftSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItems = @[[self backItem], [self currentPositionLabelItemWithTitle:@"用户设置" imageNamed:@"left_view_nav_user_setting"]];
    [self initializationTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[SFUserDefaults sharedUserDefaults] productListCollectionViewStyle] == ProductListCollectionViewStyleGrid)
    {
        [_tableHeaderView selecteTableStyle];
    }
    else
    {
        [_tableHeaderView selecteListStyle];
    }
}

- (void)initializationTableView
{
    [super initializationTableView];
    
    [self.tableView registerNib:NIB_NAMED([LeftViewUserSettingCell class]) forCellReuseIdentifier:kUserSettingCellIdentity];
    
    // 设置TableHeaderView
    _tableHeaderView = [LeftViewUserSettingHeaderView leftViewUserSettingHeaderViewWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 95) delegate:self];
    self.tableView.tableHeaderView = _tableHeaderView;
    
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
//    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftViewUserSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserSettingCellIdentity];
    if (0 == indexPath.row)
    {
        [cell updateUIWithTitle:@"视频预加载" highlight:NO delegate:self];
    }
    else if (1 == indexPath.row)
    {
        [cell updateUIWithTitle:@"小额免密支付" highlight:YES delegate:self];
    }
    return cell;
}

#pragma mark- LeftViewUserSettingHeaderViewDelegate

- (void)leftViewUserSettingHeaderView:(LeftViewUserSettingHeaderView *)headerView styleViewTaped:(UIImageView *)styleImageView settingType:(LeftViewUserSettingHeaderViewType)type
{
    if (LeftViewUserSettingTypeTable == type)
    {
        [[SFUserDefaults sharedUserDefaults] setProductListCollectionViewStyle:ProductListCollectionViewStyleGrid];
    }
    else if (LeftViewUserSettingTypeList == type)
    {
        [[SFUserDefaults sharedUserDefaults] setProductListCollectionViewStyle:ProductListCollectionViewStyleList];
    }
}

#pragma mark- LeftViewUserSettingCellDelegate

- (void)leftViewUserSettingCell:(LeftViewUserSettingCell *)cell selectedTitle:(NSString *)selectedTitle
{
    
}

- (void)leftViewUserSettingCell:(LeftViewUserSettingCell *)cell deselectedTitle:(NSString *)deselectedTitle
{
    
}

@end
