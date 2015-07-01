//
//  LeftAddressViewController.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftAddressViewController.h"
#import "SFAPILoader.h"
#import "LeftAddressModel.h"

static NSString * const kHeaderCellIdentity = @"HeaderCellIdentity";
static NSString * const kStrongCellIdentity = @"StrongCellIdentity";

@interface LeftAddressViewController ()
{
    LeftViewTelphonePopupView *_popupView;
    LeftAddressModel *_addressModel;
}
@end

@implementation LeftAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItems = @[[self backItem], [self currentPositionLabelItemWithTitle:@"餐厅位置"]];
    
    [self initializationTableView];
    [self createData];
}

- (void)createData {
    [SFAPILoader b_getWithURL1:[LeftAddressModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithDictionary:responseDict];
    } failed:nil];
    
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
}

- (void)refreshData {
    [SFAPILoader getWithURL3:[LeftAddressModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithDictionary:responseDict];
    } failed:^(NSURLResponse *response, NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}

- (void)analysisDataWithDictionary:(NSDictionary *)responseDict {
    _addressModel = [[LeftAddressModel alloc] initWithDictionary:responseDict[@"result"]];
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
    
}

- (void)backItemButtonClicked:(UIBarButtonItem *)buttonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initializationTableView
{
    [super initializationTableView];
    
    [self.tableView registerNib:NIB_NAMED([LeftViewPostionHeaderCell class]) forCellReuseIdentifier:kHeaderCellIdentity];
    [self.tableView registerClass:[LeftViewPostionStrongCell class] forCellReuseIdentifier:kStrongCellIdentity];
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row) {
        LeftViewPostionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kHeaderCellIdentity];
        [cell updateWithModel:_addressModel];
        return cell;
    } else if (1 == indexPath.row) {
        LeftViewPostionStrongCell *cell = [tableView dequeueReusableCellWithIdentifier:kStrongCellIdentity];
        [cell createUIWithDelegate:self];
        return  cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0f;
    switch (indexPath.row)
    {
        case 0:
            height = 250.0f;
            break;
            
        case 1:
            height = AUTO_MATE_WIDTH(72.0);
            break;
    }
    return height;
}

#pragma mark- LeftViewPostionStrongCellDelegate

- (void)leftViewPositionStrongCell:(LeftViewPostionStrongCell *)cell buttonViewTapType:(PositionStrongColumnType)type buttonView:(LeftViewPositionButtonView *)buttonView
{
    if (PositionStrongColumnTypeLocation == type) {
        [_popupView hideTelphonePopupView];
    } else if (PositionStrongColumnTypeNavigation == type) {
        [_popupView hideTelphonePopupView];
    } else if (PositionStrongColumnTypeTelephone == type) {
        if (buttonView.iconImageView.highlighted) {
            [_popupView hideTelphonePopupView];
        } else {
            if (!_popupView) {
                _popupView = [LeftViewTelphonePopupView leftViewTelphonePopupViewWithFrame:CGRectMake(0, 0, 105, 95) delegate:self];
                _popupView.firstTelLabel.text = _addressModel.telNumberArray[0];
                if (_addressModel.telNumberArray.count == 2) {
                    _popupView.secondTelLabel.text = _addressModel.telNumberArray[1];
                }
                // 调整popupView的坐标
                CGPoint center = [buttonView.superview convertPoint:buttonView.center toView:self.view];
                _popupView.center = CGPointMake(center.x - 13, center.y + 70);
                
                [self.tableView addSubview:_popupView];
            }
                [_popupView showTelphonePopupView];
        }
    }
}

#pragma mark- LeftViewTelphonePopupViewDelegate

- (void)leftViewTelphonePopupView:(LeftViewTelphonePopupView *)telphonePopupView telLabelTap:(UILabel *)telLabel labelIndex:(int)labelIndex {
    
}

@end
