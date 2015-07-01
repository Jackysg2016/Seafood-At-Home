//
//  ShoppingCarViewController.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/1.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "DetailNormalViewController.h"
#import "CreateOrderViewController.h"
#import "MainNavigationController.h"

#import "ShoppingCarModel.h"
#import "ShoppingCarDeleteModel.h"
#import "ShoppingCarChangeAmountModel.h"

#import "ShoppingCarHomeTableViewCell.h"
#import "ShoppingCarToolBarView.h"
#import "CustomIOS7AlertView.h"
#import "SelectProductAmountView.h"

#import "SFAPILoader.h"
#import "SVProgressHUD.h"
#import "SIAlertView.h"
#import "WTRequestCenter.h"
#import "SFUserDefaults.h"

#import "ShoppingCarEmptyTryViewFactory.h"

#import "SFVCProtocol.h"

@interface ShoppingCarViewController ()
<
    ShoppingCarHomeTableViewCellDelegate,
    SFVCProtocol
>
{
    NSMutableArray *_dataArray;
    ShoppingCarToolBarView *_toolBarView;
}

@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createData];
}

- (void)createUI {
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    [self.UIHelper appendingNavTitleWithString:@"购物篮"];
    [self initializationTableView];
    [self createToolBarView];
    [self updateToolBarView];
}

- (void)initializationTableView {
    [super initializationTableView];
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - STATUS_BAR_HEIGHT - ShoppingCarToolBarView.height);
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
//    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    
}

- (BOOL)checkIsEmpty {
    // 如果购物篮为空，即显示
    if([[SFUserDefaults sharedUserDefaults] requestShoppingCarCount] == 0) {
        self.navigationItem.rightBarButtonItem = nil;
        TryViewFactory <TryViewFactory> *shoppingCarEmptyTryViewFactory = [[ShoppingCarEmptyTryViewFactory alloc] init];
        [shoppingCarEmptyTryViewFactory createTryViewWithTargetView:self.view clickedCallBack:^(TryView *tryView) {
            NSUInteger VCCount = self.navigationController.viewControllers.count;
            if(VCCount > 1) {
                [self.navigationController popViewControllerAnimated:YES];
            } else if(VCCount == 1) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        return YES;
    }
    return NO;
}

// 创建数据源
- (void)createData {
    if([self checkIsEmpty]) {
        return;
    }
    
    [SFAPILoader getWithURL1:[ShoppingCarModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        _dataArray = [[NSMutableArray alloc] init];
        [self.UIHelper appendingNavTitleButtonWithString:@"编辑" selector:@selector(editingButtonClicked:) isLeft:NO];
        [self analysisDataWithResponseDict:responseDict];
        
    } failed:^(NSURLResponse *response, NSError *error) {
        [self.tableView footerEndRefreshing];
    }];
}

- (void)refreshData {
    [SFAPILoader getWithURL3:[ShoppingCarModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [_dataArray removeAllObjects];
        [self analysisDataWithResponseDict:responseDict];
    } failed:^(NSURLResponse *response, NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}

//- (void)loadMoreData {
//
//    [SFAPILoader getWithURL2:[ShoppingCarModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
//        [self analysisDataWithDictionary:responseDict];
//    } failed:^(NSURLResponse *response, NSError *error) {
//        [self.tableView footerEndRefreshing];
//    }];
//}

- (void)analysisDataWithResponseDict:(NSDictionary *)responseDict {
    int amount = 0;
    NSArray *result = responseDict[@"result"];
    for (NSDictionary *dict in result) {
        ShoppingCarModel *model = [[ShoppingCarModel alloc] initWithDictionary:dict];
        [_dataArray addObject:model];
        amount += model.amount;
    }
    [[SFUserDefaults sharedUserDefaults] setShoppingCarCountTo:amount];
    [self updateToolBarView];
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    [self.tableView reloadData];
}

// 导航栏的 编辑/完成按钮点击事件
- (void)editingButtonClicked:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"编辑"]) {
        [_toolBarView editing];
        [self.UIHelper appendingNavTitleButtonWithString:@"完成" selector:@selector(editingButtonClicked:) isLeft:NO];
    } else {
        [_toolBarView unediting];
        [self.UIHelper appendingNavTitleButtonWithString:@"编辑" selector:@selector(editingButtonClicked:) isLeft:NO];
    }
    
    [self updateToolBarView];
}

// 创建ToolBar视图
- (void)createToolBarView {
    _toolBarView = [[ShoppingCarToolBarView alloc] initWithFrame:CGRectMake(0, self.view.height - ShoppingCarToolBarView.height-20-NavigationBar_HEIGHT, SCREEN_WIDTH, ShoppingCarToolBarView.height)];
    
    // 添加按钮事件
    [_toolBarView.checkboxButton addTarget:self action:@selector(selectedAnycheckBoxClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBarView.buyButton addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBarView.deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_toolBarView];
}

// 全选/取消按钮事件
- (void)selectedAnycheckBoxClicked:(UIButton *)button {
    button.selected = !button.selected;
    
    for (ShoppingCarModel *model in _dataArray) {
        model.isSelected = button.selected;
    }
    [self updateToolBarView];
    [self.tableView reloadData];

}

// 更新ToolBar视图
- (void)updateToolBarView {
    BOOL isSelectedAll = YES;
    float sum = 0.0f;
    int amount = 0;
    
    for (ShoppingCarModel *model in _dataArray) {
        if (model.isSelected) {
            sum += model.sum;
            amount += model.amount;
        } else {
            isSelectedAll = NO;
        }
    }
    
    _toolBarView.checkboxButton.selected = isSelectedAll;
    [_toolBarView setSum:sum];
    [_toolBarView setAmount:amount];
}

// 立即购物按钮点击事件
- (void)buyButtonClicked:(UIButton *)button {
    BOOL haveProduct = NO;
    for (ShoppingCarModel *model in _dataArray) {
        if (model.isSelected) {
            haveProduct = YES;
            break;
        }
    }
    
    if (haveProduct) {
        NSMutableArray *selectedDataArray = [NSMutableArray new];
        for (ShoppingCarModel *model in _dataArray) {
            if (model.isSelected)
            [selectedDataArray addObject:model];
        }
        CreateOrderViewController *vc = [[CreateOrderViewController alloc] initWithDataArray:selectedDataArray];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"请您先选择商品再购买!"];
        [alertView addButtonWithTitle:@"好的" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView setTransitionStyle:SIAlertViewTransitionStyleFade];
        [alertView show];
    }
}

// 删除商品按钮点击事件
- (void)deleteButtonClicked:(UIButton *)button {
    BOOL haveProduct = NO;
    for (ShoppingCarModel *model in _dataArray) {
        if (model.isSelected) {
            haveProduct = YES;
            break;
        }
    }
    if (haveProduct == NO) {
        [SVProgressHUD showErrorWithStatus:@"请先选择商品再删除！"];
        return;
    }
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"您确定要删除？"];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
        [SVProgressHUD showWithStatus:@"正在删除..." maskType:SVProgressHUDMaskTypeClear];
        NSMutableArray *willDeleteModels = [[NSMutableArray alloc] init];
        NSMutableArray *willDeleteIndexPaths = [[NSMutableArray alloc] init];
        NSMutableArray *willDeleteShoppingCarIDArray = [[NSMutableArray alloc] init];
        int willDeleteAmount = 0;
        
        for (int i = 0; i<_dataArray.count; i++) {
            ShoppingCarModel * model = _dataArray[i];
            
            if (model.isSelected) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [willDeleteIndexPaths addObject:indexPath];
                [willDeleteModels addObject:model];
                [willDeleteShoppingCarIDArray addObject:@(model.shopcarID)];
                willDeleteAmount += model.amount;
            }
        }
        
        ShoppingCarDeleteModel *model = [[ShoppingCarDeleteModel alloc] init];
        model.idList = [willDeleteShoppingCarIDArray componentsJoinedByString:@","];
        [WTRequestCenter postWithURL:[ShoppingCarDeleteModel API] parameters:[model postDictionary] finished:^(NSURLResponse *response, NSData *data) {
            NSDictionary *responseDict = JSON_TO_DICT(data);
            if ([responseDict[@"ret"] intValue] == 0) {
                [[SFUserDefaults sharedUserDefaults] subtractingShoppingCarCountWithAmount:willDeleteAmount];
                [_dataArray removeObjectsInArray:willDeleteModels];
                [self.tableView deleteRowsAtIndexPaths:willDeleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
                [self updateToolBarView];
                [self checkIsEmpty];
                [SVProgressHUD showSuccessWithStatus:@"删除成功！"];
            } else {
                [SVProgressHUD showSuccessWithStatus:@"删除失败！"];
            }
        } failed:^(NSURLResponse *response, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络故障，请重试！"];
        }];
    }];
    [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView setTransitionStyle:SIAlertViewTransitionStyleFade];
    [alertView show];
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const kCellIdentity = @"Cell";
    ShoppingCarHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];
    if (!cell) {
        cell = [[ShoppingCarHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentity];
    }
    
    [cell updateViewWithModel:_dataArray[indexPath.row] delegate:self];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ShoppingCarHomeTableViewCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCarModel *model = _dataArray[indexPath.row];
    MainNavigationController *nav = [[MainNavigationController alloc] init];
    if (model.isCombo) {
        // 如果是套餐
        
    } else {
        DetailNormalViewController *vc = [[DetailNormalViewController alloc] initWithProductID:model.productID remark:model.remark];
        vc.isShowShoppingCarButton = NO;
        nav.viewControllers = @[vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}

#pragma mark- ShoppingCarHomeTableViewCellDelegate

// 每个Cell的checkBox点击事件
- (void)shoppingCarHomeTableViewCellCheckBoxButtonClicked:(ShoppingCarHomeTableViewCell *)cell model:(ShoppingCarModel *)model button:(UIButton *)button {
    model.isSelected = button.selected;
    
    [self updateToolBarView];
}

// 每个Cell的修改数量点击事件
- (void)shoppingCarHomeTableViewCellChangeAmountButtonClicked:(ShoppingCarHomeTableViewCell *)cell model:(ShoppingCarModel *)model button:(UIButton *)button {
    SelectProductAmountView *amountView = [SelectProductAmountView createView];
    amountView.maximumAmount = model.maximumAmount;
    amountView.currentAmount = model.amount;
    // testing
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    [alertView setContainerView:amountView];
    [alertView setButtonTitles:@[@"确认修改", @"取消"]];
    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        if (buttonIndex == 0) {
            ShoppingCarChangeAmountModel *changeAmountModel = [[ShoppingCarChangeAmountModel alloc] init];
            changeAmountModel.shopcarID = model.shopcarID;
            changeAmountModel.number = (int)amountView.currentAmount;
            [SVProgressHUD showWithStatus:@"请稍后" maskType:SVProgressHUDMaskTypeClear];
            [WTRequestCenter postWithURL:[ShoppingCarChangeAmountModel API] parameters:[changeAmountModel postDictionary] finished:^(NSURLResponse *response, NSData *data) {
                NSDictionary *responseDict = JSON_TO_DICT(data);
                if ([responseDict[@"ret"] intValue] == 0) {
                    [[SFUserDefaults sharedUserDefaults] subtractingShoppingCarCountWithAmount:model.amount-changeAmountModel.number];
                    model.amount = changeAmountModel.number;
                    [self.tableView reloadData];
                    [self updateToolBarView];
                    [SVProgressHUD showSuccessWithStatus:@"修改数量成功"];
                } else {
                    [SVProgressHUD showErrorWithStatus:@"修改数量失败！"];
                }
            } failed:^(NSURLResponse *response, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"由于网络故障，无法修改数量，请重试！"];
            }];
        }
        [alertView close];
     }];
    
    [alertView show];
}

@end
