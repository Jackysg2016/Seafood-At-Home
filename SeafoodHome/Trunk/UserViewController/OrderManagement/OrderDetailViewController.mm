//
//  OrderDetailViewController.m
//  SeafoodHome
//
//  Created by btw on 15/1/6.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "DetailNormalViewController.h"
#import "OrderDetailChangeInfoViewController.h"
#import "OrderDetailStep1TableViewCell.h"
#import "OrderDetailStep2TableViewCell.h"
#import "PayOrderPayWayTableViewCell.h"
#import "PayOrderTableHeaderView.h"
#import "PayOrderTableViewCell.h"
#import "SFAPILoader.h"
#import "SIAlertView.h"
#import "ShoppingCarSelectUserOnceOrderModel.h"
#import "ShoppingCarChangeOrderStateModel.h"
#import "ShoppingCarOrderUnionPayModel.h"
#import "ShoppingCarOrderUnionPayResultModel.h"
#import "SVProgressHUD.h"
#import "WTRequestCenter.h"
#import "UPPayPlugin.h"
#import "SFVCProtocol.h"

static NSString * const kCellStep1Identity = @"OrderDetailStep1TableViewCell";
static NSString * const kCellStep2Identity = @"OrderDetailStep2TableViewCell";
static NSString * const kPayWayCellIdentity = @"PayWayCell";
static NSString * const kHeaderIdentity = @"PayOrderTableHeaderView";
static NSString * const kInfoCellIdentity = @"PayOrderTableViewCell";

@interface OrderDetailViewController () <UPPayPluginDelegate, SFVCProtocol>
{
    NSMutableArray *_titles;
    NSMutableArray *_shouHuoRenDetails;
    NSArray *_payWayArray;
    ShoppingCarSelectUserOnceOrderModel *_orderModel;
    OrderPayType _selectedPayType;
    BOOL _isPaySuccessd;
}
@end

@implementation OrderDetailViewController

- (instancetype)initWithOrderID:(int)orderID {
    if (self = [super init]) {
        self.orderID = orderID;
    }
    return self;
}

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
    [self.UIHelper appendingNavTitleWithString:@"订单详情"];
    
    [self initializationTableView];
}


- (void)initializationTableView {
    [super initializationTableView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.tableView registerNib:NIB_NAMED([OrderDetailStep1TableViewCell class]) forCellReuseIdentifier:kCellStep1Identity];
    [self.tableView registerNib:NIB_NAMED([OrderDetailStep2TableViewCell class]) forCellReuseIdentifier:kCellStep2Identity];
    [self.tableView registerNib:NIB_NAMED([PayOrderPayWayTableViewCell class]) forCellReuseIdentifier:kPayWayCellIdentity];
    [self.tableView registerClass:[PayOrderTableViewCell class] forCellReuseIdentifier:kInfoCellIdentity];
    [self.tableView registerClass:[PayOrderTableHeaderView class] forHeaderFooterViewReuseIdentifier:kHeaderIdentity];
}

- (void)createData {
    _selectedPayType = OrderPayTypeNonPayment;
    if (_titles == nil) {
        _titles = [[NSMutableArray alloc] init];
    }
    if (_shouHuoRenDetails == nil) {
        _shouHuoRenDetails = [[NSMutableArray alloc] init];
    }
    
    [SFAPILoader getWithURL1:[ShoppingCarSelectUserOnceOrderModel APIWithOrderID:_orderID] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDict:responseDict];
    } failed:nil];
    
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
}

- (void)refreshData {
    _selectedPayType = OrderPayTypeNonPayment;
    [SFAPILoader getWithURL3:[ShoppingCarSelectUserOnceOrderModel APIWithOrderID:_orderID] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDict:responseDict];
    } failed:^(NSURLResponse *response, NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}

- (void)analysisDataWithResponseDict:(NSDictionary *)responseDict {
    self.tableView.tableFooterView = [[UIView alloc] init];
    NSDictionary *resultDict = [responseDict objectForKey:@"result"];
    if (resultDict && [resultDict isKindOfClass:[NSDictionary class]]) {
        _orderModel = [[ShoppingCarSelectUserOnceOrderModel alloc] initWithDictionary:resultDict];
        [_titles removeAllObjects];
        [_titles addObject:@"商品详情"];
        [_titles addObject:@"收货人详情"];
        
        [_shouHuoRenDetails removeAllObjects];
        [_shouHuoRenDetails addObject:@{@"title" : @"订单编号：", @"desc" : _orderModel.orderNumber}];
        [_shouHuoRenDetails addObject:@{@"title" : @"下单时间：", @"desc" : _orderModel.createTitme}];
        [_shouHuoRenDetails addObject:@{@"title" : @"联系姓名：", @"desc" : _orderModel.realName}];
        [_shouHuoRenDetails addObject:@{@"title" : @"电话号码：", @"desc" : _orderModel.phoneNumber}];
        [_shouHuoRenDetails addObject:@{@"title" : @"收货地址：", @"desc" : _orderModel.address}];
        [_shouHuoRenDetails addObject:@{@"title" : @"备注信息：", @"desc" : _orderModel.message}];
        
        if (_orderModel.state == OrderStateSuccess || _orderModel.state == OrderStateInbound) {
            [_shouHuoRenDetails addObject:@{@"title" : @"支付方式：", @"desc" : _orderModel.payTypeString}];
        }
        
        if (_orderModel.state == OrderStatePending ||  _orderModel.state == OrderStateInbound || _orderModel.state == OrderStateSuccess) {
            [_shouHuoRenDetails addObject:@{@"title" : @"订单总额：", @"desc" : _orderModel.totalPriceString}];
        }
        
        if (_orderModel.state == OrderStatePending) {
            [_titles addObject:@"支付方式"];
            _payWayArray = @[
                             @{@"imageNamed" : @"UnionPay", @"title" : @"银联支付"},
                             @{@"imageNamed" : @"PayWayCOD", @"title" : @"货到付款"}
                             ];
            [self createBottomPayButtonWithTitle:@"确认支付方式" action:@selector(getPayBtnClicked:)];
        }
        
        if (_orderModel.state == OrderStateAudit) {
            [self createBottomPayButtonWithTitle:@"修改收货人信息" action:@selector(changeContactInfoBtnClicked:)];
        }
        
        [_shouHuoRenDetails addObject:@{@"title" : @"订单状态：", @"desc" : _orderModel.stateString}];
        [self.tableView reloadData];
    }
    [self.tableView headerEndRefreshing];
}

// 创建TableView的FooterView为一个底部按钮
- (void)createBottomPayButtonWithTitle:(NSString *)title action:(SEL)action {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 56)];
    UIButton *getPayBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 8, AUTO_MATE_WIDTH(304), 40)];
    getPayBtn.backgroundColor = RGB(243, 161, 33);
    getPayBtn.titleLabel.font = MyFont(16);
    getPayBtn.layer.cornerRadius = 3.0f;
    getPayBtn.layer.masksToBounds = YES;
    [getPayBtn setTitle:title forState:UIControlStateNormal];
    [getPayBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:getPayBtn];
    
    self.tableView.tableFooterView = footerView;
}

// 马上支付按钮点击事件
- (void)getPayBtnClicked:(UIButton *)button {
    if (_isPaySuccessd) {
        [SVProgressHUD showErrorWithStatus:@"已经支付过了！请手动下拉刷新此页面，更新数据！"];
        return;
    }
    SIAlertView *alertView = [[SIAlertView alloc] init];
    alertView.title = @"温馨提示";
    [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
    
    if (_selectedPayType == OrderPayTypeNonPayment) {
        alertView.message = @"请您先选择支付方式！";
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    } else if (_selectedPayType == OrderPayTypeMobileUnion) {
        alertView.message = @"您选择了“银联支付”支付方式。\n点击“确定”，立即转到支付页面！";
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [SVProgressHUD showWithStatus:@"请稍后..." maskType:SVProgressHUDMaskTypeClear];
            ShoppingCarOrderUnionPayModel *orderPayModel = [[ShoppingCarOrderUnionPayModel alloc] init];
            orderPayModel.orderID = _orderModel.orderID;
            [WTRequestCenter postWithURL:[ShoppingCarOrderUnionPayModel API] parameters:[orderPayModel postDictionary] finished:^(NSURLResponse *response, NSData *data) {
                [SVProgressHUD dismiss];
                NSDictionary *responseDict = JSON_TO_DICT(data);
                ShoppingCarOrderUnionPayResultModel *payResultModel = [[ShoppingCarOrderUnionPayResultModel alloc] initWithDictionary:responseDict];
                [UPPayPlugin startPay:payResultModel.tnNumber mode:@"00" viewController:self delegate:self];
            } failed:^(NSURLResponse *response, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络故障，申请失败！"];
            }];
        }];
        [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
    } else if (_selectedPayType == OrderPayTypeCOD) {
        alertView.message = @"您选择了“货到付款”支付方式。\n点击“确定”，立即为您配！";
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [SVProgressHUD showWithStatus:@"正在提交请求..." maskType:SVProgressHUDMaskTypeClear];
            ShoppingCarChangeOrderStateModel *changeStateModel = [[ShoppingCarChangeOrderStateModel alloc] init];
            changeStateModel.orderID = _orderModel.orderID;
            [WTRequestCenter postWithURL:[ShoppingCarChangeOrderStateModel API] parameters:[changeStateModel postDictionary] finished:^(NSURLResponse *response, NSData *data) {
                NSDictionary *responseDict = JSON_TO_DICT(data);
                NSLog(@"%@", responseDict);
                if ([responseDict[@"ret"] intValue] == 0) {
                    [SVProgressHUD dismiss];
                    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"请求成功！\n货物将在不久到达，请随时留意手机！"];
                    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alertView show];
                } else {
                    [SVProgressHUD showErrorWithStatus:@"申请失败，请重试！"];
                }
            } failed:^(NSURLResponse *response, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络故障，请重试！"];
            }];
        }];
        [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
    }
    
    [alertView show];
}

// 修改收货人信息
- (void)changeContactInfoBtnClicked:(UIButton *)button {
    OrderDetailChangeInfoViewController *vc = [[OrderDetailChangeInfoViewController alloc] initWithModel:_orderModel];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [PayOrderTableHeaderView height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PayOrderTableHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderIdentity];
    if (!view) {
        view = [[PayOrderTableHeaderView alloc] initWithReuseIdentifier:kHeaderIdentity];
    }
    [view setTitle:_titles[section]];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_orderModel.state == OrderStateAudit || _orderModel.state == OrderStateAuditNotPassed) {
            return _orderModel.detailArray.count;
        } else {
            return _orderModel.resolveArray.count;
        }
    } else if (section == 1) {
        return _shouHuoRenDetails.count;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (_orderModel.state == OrderStateAudit || _orderModel.state == OrderStateAuditNotPassed) {
            return [OrderDetailStep1TableViewCell height];
        } else {
            return [OrderDetailStep2TableViewCell height];
        }
    } else if (indexPath.section == 1) {
        return [PayOrderTableViewCell height];
    } else {
        return [PayOrderPayWayTableViewCell height];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (_orderModel.state == OrderStateAudit || _orderModel.state == OrderStateAuditNotPassed) {
            OrderDetailStep1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellStep1Identity];
            [cell updateWithModel:_orderModel.detailArray[indexPath.row]];
            return cell;
        } else {
            OrderDetailStep2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellStep2Identity];
            [cell updateWithModel:_orderModel.resolveArray[indexPath.row]];
            return cell;
        }
    } else if (indexPath.section == 1) {
        PayOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kInfoCellIdentity];
        [cell updateUIWithTitle:_shouHuoRenDetails[indexPath.row][@"title"] desc:_shouHuoRenDetails[indexPath.row][@"desc"]];
        return cell;
    } else {
        NSDictionary *payWayDict = [_payWayArray objectAtIndex:indexPath.row];
        PayOrderPayWayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPayWayCellIdentity];
        [cell updateUIWithImageNamed:payWayDict[@"imageNamed"] title:payWayDict[@"title"]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (_orderModel.state == OrderStateAudit || _orderModel.state == OrderStateAuditNotPassed) {
            
        } else {
            ShoppingCarSelectUserOnceOrderResolveModel *model = _orderModel.resolveArray[indexPath.row];
            DetailNormalViewController *vc = [[DetailNormalViewController alloc] initWithProductID:model.productID];
            vc.isShowShoppingCarButton = NO;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            _selectedPayType = OrderPayTypeMobileUnion;
        } else if (indexPath.row == 1) {
            _selectedPayType = OrderPayTypeCOD;
        }
    }
}

#pragma mark- UPPayPluginResultDelegate
-(void)UPPayPluginResult:(NSString*)result {
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:nil];
    alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
    if ([result isEqualToString:@"success"]) {
        [SVProgressHUD showWithStatus:@"正在处理..." maskType:SVProgressHUDMaskTypeClear];
        alertView.message = @"恭喜您支付成功！";
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [self refreshData];
        }];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [alertView show];
        });
    } else if ([result isEqualToString:@"cancel"]) {
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        alertView.message = @"您放弃了支付，交易失败！";
        [alertView show];
    } else {
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        alertView.message = @"发生未知错误，支付失败，请联系客服！";
        [alertView show];
    }
}

@end
