//
//  TipsViewController.m
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "TipsViewController.h"
#import "TipsTableViewCell.h"
#import "SFAPILoader.h"
#import "TipsModel.h"
#import "TipsDetailViewController.h"
#import "SFVCProtocol.h"

static NSString * const kCellIdentity = @"TipsTableViewCell";

@interface TipsViewController() <SFVCProtocol>
{
    NSMutableArray *_dataArray;
}
@end

@implementation TipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self createData];
}

- (void)createUI {
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSearchBar];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSlidingMenuButton];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeShoppingCarButton];
    
    [self initializationTableView];
}

- (void)createData {
    _dataArray = [[NSMutableArray alloc] init];
    [SFAPILoader getWithURL1:[TipsModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDict:responseDict];
    } failed:nil];
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
}

- (void)refreshData {
    [SFAPILoader getWithURL3:[TipsModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [_dataArray removeAllObjects];
        [self analysisDataWithResponseDict:responseDict];
    } failed:^(NSURLResponse *response, NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}

- (void)analysisDataWithResponseDict:(NSDictionary *)responseDict {
    for (NSDictionary *dataDict in responseDict[@"result"]) {
        TipsModel *tipModel = [[TipsModel alloc] initWithDictionary:dataDict];
        [_dataArray addObject:tipModel];
    }
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
}

- (void)initializationTableView {
    [super initializationTableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerNib:NIB_NAMED([TipsTableViewCell class]) forCellReuseIdentifier:kCellIdentity];
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];
    [cell updateWithModel:_dataArray[indexPath.row]];
    return [cell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];
    [cell updateWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TipsDetailViewController *tipsDetailVC = [[TipsDetailViewController alloc] initWithTipModel:_dataArray[indexPath.row]];
    [self.navigationController pushViewController:tipsDetailVC animated:YES];
}

@end
