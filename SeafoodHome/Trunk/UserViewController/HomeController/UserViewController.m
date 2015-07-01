//
//  UserViewController.m
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "UserViewController.h"
#import "UserPrefixNavController.h"
#import "SFUserDefaults.h"
#import "UserPrefixNavController.h"
#import "SIAlertView.h"
#import "SFVCProtocol.h"

#import "TryView.h"
#import "UserUnLoginTryViewFactory.h"

static NSString * const kCellIdentity = @"Cell";
static NSString * const kHeaderViewIdentity = @"HeaderView";

@interface UserViewController () <SFVCProtocol> {
    NSMutableArray *_dataArray;
     TryView <TryView> *_tryView;
}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self createData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[SFUserDefaults sharedUserDefaults] isLogined]) {
        _tryView.hidden = YES;
    } else {
        _tryView.hidden = NO;
    }
}

- (void)createUI {
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSearchBar];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSlidingMenuButton];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeShoppingCarButton];
    
    [self initializationTableView];
    
    TryViewFactory <TryViewFactory> *userUnLoginTryViewFactory = [[UserUnLoginTryViewFactory alloc] init];
    _tryView = [userUnLoginTryViewFactory createTryViewWithTargetView:self.view clickedCallBack:^(TryView *tryView) {
        UserPrefixNavController *nav = [[UserPrefixNavController alloc] init];
        [self presentViewController:nav animated:YES completion:nil];
    }];
}

- (void)createData {
    _dataArray = [[NSMutableArray alloc] init];
    
    NSArray *titlesArray = @[@"账户设置", @"订单管理", @"退出登录"];
    for (int i = 0; i<titlesArray.count; i++) {
        UserSettingHeaderViewModel *model = [[UserSettingHeaderViewModel alloc] init];
        model.title = titlesArray[i];
        model.type = i;
        
        if (0 == i) {
            model.isSelected = YES;
            model.isCanFold = YES;
        }
        
        [_dataArray addObject:model];
    }
    
    [self.tableView reloadData];
}

- (void)initializationTableView {
    [super initializationTableView];
    
    [self.tableView registerNib:NIB_NAMED([UserSettingTableViewCell class]) forCellReuseIdentifier:kCellIdentity];
    [self.tableView registerNib:NIB_NAMED([UserSettingHeaderView class]) forHeaderFooterViewReuseIdentifier:kHeaderViewIdentity];
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UserSettingHeaderViewModel *model = _dataArray[section];
                                   
    if (model.isCanFold && model.isSelected) {
        return 1;
    }
    else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UserSettingHeaderViewModel *model = _dataArray[section];
    
    UserSettingHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewIdentity];
    [headerView updateUIWithModel:model delegate:self];
    headerView.tag = section;
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];
    cell.delegate = self;
    return cell;
}

#pragma mark- UserSettingHeaderViewDelegate
- (void)userSettingHeaderViewClicked:(UserSettingHeaderView *)headerView titleText:(NSString *)titleText {
    NSInteger currentSectionIndex = headerView.tag;
    UserSettingHeaderViewModel *model = [_dataArray objectAtIndex:currentSectionIndex];
    
    if (model.isCanFold) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:currentSectionIndex];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationBottom];
    }
    
    if (UserSettingHeaderViewTypeAccountSettings == model.type) {
        
    } else if (UserSettingHeaderViewTypeOrderManagement == model.type) {
        OrderManagementViewController *vc = [[OrderManagementViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (UserSettingHeaderViewTypeOutLogin == model.type) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"您确定要退出登录吗？"];
        [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
        [alertView addButtonWithTitle:@"是的" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [[SFUserDefaults sharedUserDefaults] outLogin];
            [[SFUserDefaults sharedUserDefaults] shoppingCarCountReset];
            _tryView.hidden = NO;
        }];
        [alertView addButtonWithTitle:@"不要" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView show];
    }
}

#pragma mark- UserSettingTableViewCellDelegate
- (void)userSettingTableViewCell:(UserSettingTableViewCell *)cell clickedType:(UserSettingTableViewCellButtonType)type {
    if (UserSettingTableViewCellButtonTypeChangeSelfInfo == type) {
        UserChangeInfoViewController *vc = [[UserChangeInfoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (UserSettingTableViewCellButtonTypeChangePassword == type) {
        UserChangePasswordViewController *vc = [[UserChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (UserSettingTableViewCellButtonTypeBoundMailOrPhone == type) {
        UserBindingInfoViewController *vc = [[UserBindingInfoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (UserSettingTableViewCellButtonTypeReadyInfoSetting == type) {
        UserBookInformationViewController *vc = [[UserBookInformationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (UserSettingTableViewCellButtonTypePayManage == type) {
        UserPaymentManagementViewController *vc = [[UserPaymentManagementViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
