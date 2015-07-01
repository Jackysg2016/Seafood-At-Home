//
//  OrderDetailChangeInfoViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/21.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "MainViewController.h"

@class ShoppingCarSelectUserOnceOrderModel;

@interface OrderDetailChangeInfoViewController : MainViewController

@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderDateLabel;
@property (strong, nonatomic) IBOutlet UITextField *contactsTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (strong, nonatomic) IBOutlet UITextView *addressTV;
@property (strong, nonatomic) IBOutlet UITextField *noteTF;
@property (strong, nonatomic) IBOutlet UIButton *commitBtn;

@property (strong, nonatomic) ShoppingCarSelectUserOnceOrderModel *orderModel;

- (instancetype)initWithModel:(ShoppingCarSelectUserOnceOrderModel *)orderModel;

@end
