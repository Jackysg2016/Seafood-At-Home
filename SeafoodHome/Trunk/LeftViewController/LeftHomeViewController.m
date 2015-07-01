//
//  LeftHomeViewController.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftHomeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "ShoppingCarViewController.h"
#import "MainNavigationController.h"
#import "SFUserDefaults.h"
#import "UserPrefixNavController.h"
#import "LeftHomeModel.h"
#import "SFAPILoader.h"
#import "DetailNormalViewController.h"
#import "MainNavigationController.h"
#import "SIAlertView.h"
#import "TypeListViewController.h"

static NSString * const kHeaderCellIdentity = @"HeaderCellIdentity";
static NSString * const kCoverCellIdentity = @"CoverCellIdentity";
static NSString * const kStrongColumnCellIdentity = @"StrongColumnCellIdentity";
static NSString * const kBottomCellIdentity = @"BottomCellIdentity";

@interface LeftHomeViewController () {
    UIWebView *_callTelWebView;
    LeftHomeModel *_leftHomeModel;
}
@end

@implementation LeftHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializationTableView];
    [self createNavLeftItem];
    [self createData];
}

- (void)createData {
    [SFAPILoader b_getWithURL1:[LeftHomeModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithDictionary:responseDict];
    } failed:nil];
    
    
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
}

- (void)refreshData {
    [SFAPILoader getWithURL2:[LeftHomeModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithDictionary:responseDict];
    } failed:^(NSURLResponse *response, NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}

- (void)analysisDataWithDictionary:(NSDictionary *)responseDict {
    _leftHomeModel = [[LeftHomeModel alloc] initWithDictionary:responseDict[@"result"]];
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
}

- (void)initializationTableView {
    [super initializationTableView];
    
    [self.tableView registerNib:NIB_NAMED([LeftViewHomeHeaderCell class]) forCellReuseIdentifier:kHeaderCellIdentity];
    [self.tableView registerClass:[LeftViewHomeCoverCell class] forCellReuseIdentifier:kCoverCellIdentity];
    [self.tableView registerClass:[LeftViewHomeStrongColumnCell class] forCellReuseIdentifier:kStrongColumnCellIdentity];
    [self.tableView registerNib:NIB_NAMED([LeftViewHomeBottomCell class]) forCellReuseIdentifier:kBottomCellIdentity];
}

- (void)createNavLeftItem {
    self.navigationItem.leftBarButtonItem = [self currentPositionLabelItemWithTitle:@"首页" imageNamed:@"left_nav_home_icon"];
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        LeftViewHomeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kHeaderCellIdentity];
        cell.delegate = self;
        [cell updateWithModelArray:_leftHomeModel.favourBreedArray];
        return cell;
    } else if (1 == indexPath.row) {
        LeftViewHomeCoverCell *cell = [tableView dequeueReusableCellWithIdentifier:kCoverCellIdentity];
        [cell createUIWithImagesURLArray:nil delegate:self];
        
        // testing...
        NSMutableArray *imagesURLArray = [NSMutableArray new];
        for (int i = 0; i<_leftHomeModel.coversArray.count; i++)
        {
            HomeCoverModel *coverModel = [_leftHomeModel.coversArray objectAtIndex:i];
            [imagesURLArray addObject:coverModel.imageURL];
        }
        
        cell.imagesURLArray = imagesURLArray;
        
        return  cell;
    } else if (2 == indexPath.row) {
        LeftViewHomeStrongColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:kStrongColumnCellIdentity];
        [cell createUIWithDelegate:self];
        return cell;
    } else if (3 == indexPath.row) {
        LeftViewHomeBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:kBottomCellIdentity];
        cell.delegate = self;
        return  cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    
    switch (indexPath.row) {
        case 0:
            height = 100.0f;
            break;
            
        case 1:
            height = 126.0f;
            break;
        
        case 2:
            height = AUTO_MATE_WIDTH(90.0f);
            break;
            
        case 3:
            height = 40.0f;
            break;
    }
    
    return height;
}

#pragma mark- LeftViewHomeHeaderCellDelegate

- (void)leftViewHomeHeaderCell:(LeftViewHomeHeaderCell *)cell buttonViewTapType:(HomeHeaderViewType)type {
    if (type < 3) {
        LeftHomeFavourBreedModel *favourBreedModel = _leftHomeModel.favourBreedArray[type];
        RemarkSymbolType remark = favourBreedModel.remark;
        NSString *APIName = [[SFAPILoader remarkTypeDictionary] objectForKey:@(remark)];
        NSString *categoryID = [NSString stringWithFormat:@"%d", favourBreedModel.categoryID];
        NSString *breadID = [NSString stringWithFormat:@"%d", favourBreedModel.breedID];
        if ([categoryID isEqualToString:@"0"]) {
            categoryID = @"";
        }
        if ([breadID isEqualToString:@"0"]) {
            breadID = @"";
        }
        NSString *APIFormat = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=%@&categoryid=%@&breedid=%@&size=16&index=", APIName, categoryID, breadID];
        TypeListViewController *typeListVC = [[TypeListViewController alloc] initWithAPIFormat:APIFormat remark:remark];
        MainNavigationController *mainNav = [[MainNavigationController alloc] initWithRootViewController:typeListVC];
        [self presentViewController:mainNav animated:YES completion:nil];
    } else if (HomeHeaderViewTypeShopPosition == type) {
        LeftAddressViewController *vc = [[LeftAddressViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark- LeftViewHomeStrongColumnCellDelegate

- (void)leftViewHomeStrongColumnCell:(UITableViewCell *)cell buttonViewTapType:(StrongColumnType)type {
    if (StrongColumnTypeShoppingCar == type) {
        if (![[SFUserDefaults sharedUserDefaults] isLogined]) {
            UserPrefixNavController *nav = [[UserPrefixNavController alloc] init];
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
        
        ShoppingCarViewController *vc = [[ShoppingCarViewController alloc] init];
        MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    } else if (StrongColumnTypeMyAccount == type) {
        UITabBarController *centerVC = (UITabBarController *)self.mm_drawerController.centerViewController;
        centerVC.selectedIndex = 4;
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    } else if (StrongColumnTypeUserSetting == type) {
        LeftSettingViewController *vc = [[LeftSettingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark- LeftViewHomeCoverCellDelegate

- (void)leftViewHomeCoverCell:(LeftViewHomeCoverCell *)cell clickedIndex:(int)clickedIndex {
    HomeCoverModel *coverModel = _leftHomeModel.coversArray[clickedIndex];
    DetailNormalViewController *detailVC = [[DetailNormalViewController alloc] initWithProductID:coverModel.productID remark:coverModel.remark];
    MainNavigationController *mainNav = [[MainNavigationController alloc] initWithRootViewController:detailVC];
    [self presentViewController:mainNav animated:YES completion:nil];
}

- (void)leftViewHomeBottomCellTaped:(LeftViewHomeBottomCell *)cell {
    if (_callTelWebView == nil) {
        _callTelWebView = [[UIWebView alloc] init];
        [self.view addSubview:_callTelWebView];
    }
    
    SIAlertView *telAlertView = [[SIAlertView alloc] initWithTitle:@"联系客服" andMessage:@"请选择客服的电话号码："];
    for (NSString *telNumber in _leftHomeModel.telNumberArray) {
        [telAlertView addButtonWithTitle:telNumber type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
            // 拨打电话
            NSString *telStr = [@"tel://" stringByAppendingString:telNumber];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:telStr]];
            [_callTelWebView loadRequest:request];
            [alertView dismissAnimated:YES];
        }];
    }
    [telAlertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
    telAlertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
    [telAlertView show];
}

@end
