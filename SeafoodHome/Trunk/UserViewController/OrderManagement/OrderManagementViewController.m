//
//  OrderManagementViewController.m
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "OrderManagementViewController.h"
#import "OrderDetailViewController.h"
#import "OrderManagementTableViewCell.h"
#import "ShoppingCarSelectUserAllOrderModel.h"
#import "ShoppingCarDeleteOrderModel.h"
#import "SFAPILoader.h"
#import "SVProgressHUD.h"
#import "SIAlertView.h"
#import "WTRequestCenter.h"
#import "SFVCProtocol.h"

static NSString * const kCellIdentity = @"OrderManagementTableViewCell";

@interface OrderManagementViewController () <SFVCProtocol> {
    NSMutableArray *_dataArray;
    int _pageIndex;
}
@end

@implementation OrderManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self createData];
}

- (void)createUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    [self.UIHelper appendingNavTitleWithString:@"订单管理"];
    [self initializationTableView];

}

- (void)createData {
    _dataArray = [[NSMutableArray alloc] init];
    _pageIndex = 1;
    [SFAPILoader getWithURL1:[ShoppingCarSelectUserAllOrderModel APIWithIndex:_pageIndex] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDict:responseDict];
    } failed:nil];
    
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMore)];
}

- (void)refreshData {
    _pageIndex = 1;
    [SFAPILoader getWithURL3:[ShoppingCarSelectUserAllOrderModel APIWithIndex:_pageIndex] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [_dataArray removeAllObjects];
        [self analysisDataWithResponseDict:responseDict];
    } failed:^(NSURLResponse *response, NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}

- (void)loadMore {
    _pageIndex ++;
    [SFAPILoader getWithURL2:[ShoppingCarSelectUserAllOrderModel APIWithIndex:_pageIndex] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDict:responseDict];
    } failed:^(NSURLResponse *response, NSError *error) {
        [self.tableView footerEndRefreshing];
    }];
}

- (void)analysisDataWithResponseDict:(NSDictionary *)responseDict {
    NSArray *result = [responseDict objectForKey:@"result"];
    for (NSDictionary *tempDict in result) {
        ShoppingCarSelectUserAllOrderModel *model = [[ShoppingCarSelectUserAllOrderModel alloc] initWithDictionary:tempDict];
        [_dataArray addObject:model];
    }
    
    [self.tableView reloadData];
    [self.tableView footerEndRefreshing];
    [self.tableView headerEndRefreshing];
}

- (void)initializationTableView {
    [super initializationTableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerNib:NIB_NAMED([OrderManagementTableViewCell class]) forCellReuseIdentifier:kCellIdentity];
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];
    ShoppingCarSelectUserAllOrderModel *model = _dataArray[indexPath.row];
    [cell updateWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [OrderManagementTableViewCell height];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCarSelectUserAllOrderModel *model =_dataArray[indexPath.row];
    if (model.state == OrderStateAuditNotPassed || model.state == OrderStateAudit) {
        return YES;
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ShoppingCarSelectUserAllOrderModel *model = _dataArray[indexPath.row];
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"您确定要删除该订单？"];
        [alertView addButtonWithTitle:@"是的" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [SVProgressHUD showWithStatus:@"正在删除该订单..." maskType:SVProgressHUDMaskTypeGradient];
            ShoppingCarDeleteOrderModel *delModel = [[ShoppingCarDeleteOrderModel alloc] init];
            delModel.orderID = model.orderID;
            [WTRequestCenter postWithURL:[ShoppingCarDeleteOrderModel API] parameters:[delModel postDictionary] finished:^(NSURLResponse *response, NSData *data) {
                NSDictionary *responseDict = JSON_TO_DICT(data);
                if (responseDict[@"ret"]) {
                    if ([responseDict[@"ret"] intValue] == 0) {
                        [SVProgressHUD showSuccessWithStatus:@"删除订单成功！"];
                        [_dataArray removeObjectAtIndex:indexPath.row];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    } else {
                        [SVProgressHUD showErrorWithStatus:responseDict[@"msg"]];
                    }
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"删除订单成功！"];
                }
            } failed:^(NSURLResponse *response, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络故障，删除订单失败！"];
            }];
            
        }];
        [alertView addButtonWithTitle:@"不要" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView show];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCarSelectUserAllOrderModel *model = [_dataArray objectAtIndex:indexPath.row];
    OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] initWithOrderID:model.orderID];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

@end
