//
//  OrderDetailChangeInfoViewController.m
//  SeafoodHome
//
//  Created by btw on 15/1/21.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "OrderDetailChangeInfoViewController.h"
#import "ShoppingCarSelectUserOnceOrderModel.h"
#import "ShoppingCarChangeOrderModel.h"
#import "RegExpValidate.h"
#import "WTRequestCenter.h"
#import "SIAlertView.h"
#import "SVProgressHUD.h"

@interface OrderDetailChangeInfoViewController ()
{
    UIColor *tf_bg_color;
    NSArray *_textFields;
}
@end

@implementation OrderDetailChangeInfoViewController

- (void)awakeFromNib {
    
}

- (instancetype)initWithModel:(ShoppingCarSelectUserOnceOrderModel *)orderModel {
    if (self = [super init]) {
        self.orderModel = orderModel;
        tf_bg_color = [RGB(242, 240, 236) colorWithAlphaComponent:0.5];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.UIHelper appendingNavTitleWithString:@"修改收货人信息"];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    
    [self createUI];
    [self createData];
}

- (void)createUI {
    _addressTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _addressTV.layer.borderWidth = 1.0f;
    _addressTV.layer.cornerRadius = 3.0f;
    _addressTV.layer.masksToBounds = YES;
    _addressTV.showsHorizontalScrollIndicator = NO;
    _addressTV.backgroundColor = tf_bg_color;
    
    _commitBtn.layer.cornerRadius = 3.0f;
    _commitBtn.layer.masksToBounds = YES;
    [_commitBtn addTarget:self action:@selector(commitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 修改TextField的外观
    _textFields = @[_contactsTF, _phoneNumberTF, _noteTF];
    for (UITextField *textField in _textFields) {
        textField.backgroundColor = tf_bg_color;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0f;
        textField.layer.cornerRadius = 3.0f;
        textField.layer.masksToBounds = YES;
    }
}

- (void)createData {
    _orderNumberLabel.text = _orderModel.orderNumber;
    _orderDateLabel.text = _orderModel.createTitme;
    _contactsTF.text = _orderModel.realName;
    _phoneNumberTF.text = _orderModel.phoneNumber;
    _noteTF.text = _orderModel.message;
    _addressTV.text = _orderModel.address;
}

// 确认按钮点击事件
- (void)commitBtnClicked:(UIButton *)button {
    NSString *errMsg = nil;
    if (_contactsTF.text.length == 0) {
        errMsg = @"联系人不能为空！";
    } else if (_phoneNumberTF.text.length == 0) {
        errMsg = @"手机号码不能为空！";
    } else if (![RegExpValidate validateMobile:_phoneNumberTF.text]) {
        errMsg = @"手机号码格式不正确！";
    } else if (_addressTV.text.length ==0) {
        errMsg = @"收货地址不能为空！";
    }
    
    SIAlertView *alertView = [[SIAlertView alloc] init];
    alertView.title = @"温馨提示";
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    if (errMsg) {
        alertView.message = errMsg;
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    } else {
        alertView.message = @"您确定要修改收货人信息吗？";
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [SVProgressHUD showWithStatus:@"请稍后" maskType:SVProgressHUDMaskTypeClear];
            ShoppingCarChangeOrderModel *changeOrderModel = [[ShoppingCarChangeOrderModel alloc] init];
            changeOrderModel.orderID = _orderModel.orderID;
            changeOrderModel.realName = _contactsTF.text;
            changeOrderModel.phone = _phoneNumberTF.text;
            changeOrderModel.address = _addressTV.text;
            changeOrderModel.message = _noteTF.text;
            [WTRequestCenter postWithURL:[ShoppingCarChangeOrderModel API] parameters:[changeOrderModel postDictionary] finished:^(NSURLResponse *response, NSData *data) {
                NSDictionary *responseDict = JSON_TO_DICT(data);
                if ([responseDict[@"ret"] intValue] == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功！"];
                    // 1秒钟后跳转
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
                    dispatch_after(popTime, dispatch_get_main_queue(), ^{
                       [self.navigationController popViewControllerAnimated:YES];
                    });
                } else {
                    [SVProgressHUD showErrorWithStatus:@"修改失败！"];
                }
            } failed:^(NSURLResponse *response, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络故障，修改收货人信息失败！"];
            }];
        }];
        [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
    }
    [alertView show];
}

@end
