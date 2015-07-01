//
//  CreateOrderViewController.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/2.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "CreateOrderViewController.h"
#import "CreateOrderTableViewCell.h"
#import "CreateOrderTableFooterView.h"
#import "ShoppingCarModel.h"
#import "ShoppingCarCreateOrderModel.h"
#import "SFUserDefaults.h"
#import "SIAlertView.h"
#import "SVProgressHUD.h"
#import "WTRequestCenter.h"
#import "RegExpValidate.h"
#import "SFVCProtocol.h"

static NSString * const kCreateOrderTableViewCell = @"CreateOrderTableViewCell";

@interface CreateOrderViewController () <UITextFieldDelegate, UITextViewDelegate, SFVCProtocol> {
    CreateOrderTableFooterView *_footerView;
}
@end

@implementation CreateOrderViewController

- (instancetype)initWithDataArray:(NSArray *)dataArray {
    if (self = [super init]) {
        self.dataArray = dataArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI {
    [self.UIHelper appendingNavTitleWithString:@"填写订单"];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    
    [self initializationTableView];
    [self createUserInfoToFooterView];
}

- (void)initializationTableView {
    [super initializationTableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    // 创建TableFooterView
    _footerView = [CreateOrderTableFooterView createOrderTableFooterViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CreateOrderTableFooterView.height) delegate:self];
    [_footerView.commitBtn addTarget:self action:@selector(commitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = _footerView;
}

- (void)createUserInfoToFooterView {
    NSDictionary *userInfo = [[SFUserDefaults sharedUserDefaults] requestUserInfo];
    _footerView.contactsTF.text = userInfo[kUserInfoKeyRealName];
    _footerView.phoneNumberTF.text = userInfo[kUserInfoKeyPhoneNumber];
    _footerView.addressTV.text = userInfo[kUserInfoKeyAddress];
}

// 提交按钮点击事件
- (void)commitBtnClicked:(UIButton *)button {
    NSString *errMsg = nil;
    if (_footerView.contactsTF.text.length == 0) {
        errMsg = @"请填写联系人姓名！";
    } else if (_footerView.phoneNumberTF.text.length == 0) {
        errMsg = @"请填写联系人的手机号码！";
    } else if (![RegExpValidate validateMobile:_footerView.phoneNumberTF.text]) {
        errMsg = @"请填写正确的手机号码！";
    } else if (_footerView.addressTV.text.length == 0) {
        errMsg = @"请填写联系人的收货地址！";
    }
    
    if (errMsg) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"错误提示" andMessage:errMsg];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:nil];
        [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
        [alertView show];
    } else {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"您确认要提交此订单吗？"];
        [alertView addButtonWithTitle:@"是的" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [SVProgressHUD showWithStatus:@"正在生成订单" maskType:SVProgressHUDMaskTypeGradient];
            // 取到多少个商品
            int productAmount = 0;
            // 取到商品的编号（多个）
            NSMutableArray *shopcarListArray = [[NSMutableArray alloc] init];
            for (ShoppingCarModel *model in _dataArray) {
                [shopcarListArray addObject:[NSString stringWithFormat:@"%d", model.shopcarID]];
                productAmount += model.amount;
            }
            NSString *shopcarListString = [shopcarListArray componentsJoinedByString:@","];

            ShoppingCarCreateOrderModel *model = [[ShoppingCarCreateOrderModel alloc] init];
            model.shopcarList = shopcarListString;
            model.realName = _footerView.contactsTF.text;
            model.phone = _footerView.phoneNumberTF.text;
            model.address = _footerView.addressTV.text;
            model.message = _footerView.noteTF.text;
            
            SIAlertView *resultAlertView = [[SIAlertView alloc] init];
            [WTRequestCenter postWithURL:[ShoppingCarCreateOrderModel API] parameters:[model postDictionary] finished:^(NSURLResponse *response, NSData *data) {
                [SVProgressHUD dismiss];
                NSDictionary *dict = JSON_TO_DICT(data);
                if ([dict[@"ret"] intValue] == 0) {
                    resultAlertView.title = @"温馨提示";
                    resultAlertView.message = @"成功提交订单，请等待审核\n期间可在用户中心的“订单管理”页面查看更多详情和操作，谢谢！";
                    [resultAlertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
                        [self dismissViewControllerAnimated:YES completion:^{
                            [[SFUserDefaults sharedUserDefaults] subtractingShoppingCarCountWithAmount:productAmount];
                        }];
                    }];
                } else {
                    alertView.title = @"错误提示";
                    if (dict[@"msg"] && [dict[@"msg"] length] > 0) {
                        resultAlertView.message = dict[@"msg"];
                    } else {
                        resultAlertView.message = @"订单提交失败，请尝试！";
                    }
                    [resultAlertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:nil];
                }
                [resultAlertView show];
            } failed:^(NSURLResponse *response, NSError *error) {
                [SVProgressHUD dismiss];
                resultAlertView.title = @"错误提示";
                resultAlertView.message = @"网络故障，订单提交失败！";
                [resultAlertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:nil];
                [resultAlertView show];
            }];
        }];
        [alertView addButtonWithTitle:@"不要" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
        [alertView show];
    }
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCreateOrderTableViewCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:kCreateOrderTableViewCell owner:self options:nil] lastObject];
    }
    [cell updateUIWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CreateOrderTableViewCell height];
}

#pragma mark- UITextFieldDelegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"%@", textField.placeholder);
    return YES;
}

@end
